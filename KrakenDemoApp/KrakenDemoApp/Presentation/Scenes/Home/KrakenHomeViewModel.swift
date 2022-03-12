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
    public var selectedPair: String? = nil
    
    private let timer = Timer.publish(
            every: 60, tolerance: 0.5,
            on: .main, in: .common
        )
        .autoconnect()
        //.merge(with: Just(Date()))
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
        
        timer.sink { _ in
            if self.selectedPair != nil {
                self.tickerCase.execute(pairKey: self.selectedPair!)
                    .sink { _ in
                        
                    } receiveValue: { tickerDictionary in
                        output.tickers.merge(tickerDictionary) { oldTicker, newTicker in
                            newTicker
                        }
                    }
                    .store(in: &self.cancelBag)
            } else {
                for pair in output.pairs {
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
        }
        .store(in: &cancelBag)
        
        input.reloadTrigger.sink { _ in
            for pair in output.pairs {
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
        .store(in: &cancelBag)
        
        input.selectPair?
            .sink(receiveValue: { cellVm in
                self.selectedPair = cellVm.name
                print("pair \(cellVm.name) was selected")
                self.navigationDirection = .forward(destination: .pairDetails(cellVm: cellVm), style: .push)
            })
            .store(in: &cancelBag)

        return output
    }
}
