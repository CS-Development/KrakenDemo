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
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    struct Input {
        var selectPair: AnyPublisher<PairCellViewModel, Never>? = nil
    }
    
    // Output
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
        
        input.selectPair?
            .sink(receiveValue: { _ in
                print("pair was selected")
                self.navigationDirection = .forward(destination: .pairDetails, style: .push)
            })
            .store(in: &cancelBag)

        return output
    }
}
