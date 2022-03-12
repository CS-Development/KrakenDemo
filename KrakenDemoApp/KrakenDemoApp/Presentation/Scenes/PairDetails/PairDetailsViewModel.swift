//
//  PairDetailsViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class PairDetailsViewModel: ObservableObject {

    private var cancelBag = Set<AnyCancellable>()
    
    private let model: (pair: TradingAssetPair, ticker: Ticker)
    
    // Input
    struct Input {
        let loader: AnyPublisher<Void, Never>
    }
    
    // Output
    final class Output: ObservableObject {
        @Published var pairName = ""
        @Published var price = ""
        @Published var priceChange = 0.0
    }
    
    // MARK: - Init
    
    internal init(model: (pair: TradingAssetPair, ticker: Ticker)) {
        self.model = model
    }
    
    func transform(_ input: Input) -> Output {
        let model = input.loader.map { self.model }
        
        let output = Output()

        // map input and use cases to output
        
        model
            .map { $0.pair.wsname ?? "-" }
            .assign(to: \.pairName, on: output)
            .store(in: &cancelBag)
        
        model
            .map { $0.ticker.lastTrade.first ?? "-" }
            .assign(to: \.price, on: output)
            .store(in: &cancelBag)
        
        model
            .map {
                guard let current = $0.ticker.lastTrade.first,
                      let currentValue = Double(current),
                      let openingValue = Double($0.ticker.opening)
                else { return -999999999.9999 }
                
                let pricePercentChange = (currentValue - openingValue) / openingValue
                return pricePercentChange
            }
            .assign(to: \.priceChange, on: output)
            .store(in: &cancelBag)

        return output
    }
}
