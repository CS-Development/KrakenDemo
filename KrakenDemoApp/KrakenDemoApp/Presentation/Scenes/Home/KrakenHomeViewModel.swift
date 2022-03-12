//
//  KrakenHomeViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class KrakenHomeViewModel: ObservableObject {

    @Published var navigationDirection: NavigationDirection?
    
    public let pairsCase: LoadTradingAssetPairsUseCaseType
    public let tickerCase: LoadTickerUseCaseType
    
    private let timer = Timer.publish(
            every: 60, tolerance: 0.5,
            on: .main, in: .common
        )
        .autoconnect()
        .merge(with: Just(Date()))
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: -  Input
    struct Input {
        let reloadTrigger: AnyPublisher<Void, Never>
        var selectPair: AnyPublisher<PairCellViewModel, Never>? = nil
    }
    
    // MARK: -  Output
    final class Output: ObservableObject {
        @Published public var pairs: [String : TradingAssetPair] = [:]
        @Published public var tickers: [String : Ticker] = [:]
    }
    
    // MARK: - Init
    
    init(pairsCase: LoadTradingAssetPairsUseCaseType, tickerCase: LoadTickerUseCaseType) {
        self.pairsCase = pairsCase
        self.tickerCase = tickerCase
    }
    
    // MARK: - Input/Output redux transform
    
    func transform(_ input: Input) -> Output {
        
        let output = Output()

        // map input and use cases to output
        
        timer.sink { _ in
            self.pairsCase.execute()
                .sink { completion in
                    // TODO
                } receiveValue: { pairs in
                    output.pairs = pairs
                    for pair in pairs {
                        self.tickerCase.execute(pairKey: pair.key)
                            .sink { _ in
                                
                            } receiveValue: { tickerDictionary in
                                output.tickers.merge(tickerDictionary) { oldTicker, newTicker in
                                    newTicker
                                }
                            }
                            .store(in: &self.cancelBag)
                    }
                    
                }
                .store(in: &self.cancelBag)
        }
        .store(in: &cancelBag)
        
        input.reloadTrigger.sink { _ in
            self.pairsCase.execute()
                .sink { completion in
                    // TODO
                } receiveValue: { pairs in
                    output.pairs = pairs
                    for pair in pairs {
                        self.tickerCase.execute(pairKey: pair.key)
                            .sink { _ in
                                
                            } receiveValue: { tickerDictionary in
                                output.tickers.merge(tickerDictionary) { oldTicker, newTicker in
                                    newTicker
                                }
                            }
                            .store(in: &self.cancelBag)
                    }
                    
                }
                .store(in: &self.cancelBag)
        }
        .store(in: &cancelBag)
        
        input.selectPair?
            .sink(receiveValue: { _ in
                print("pair was selected")
                self.navigationDirection = .forward(destination: .pairDetails, style: .push)
            })
            .store(in: &cancelBag)

        return output
    }
}
