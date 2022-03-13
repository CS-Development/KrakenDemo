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
    
    private let ohlcCase: LoadOHLCDataUseCaseType
    
    // Input
    struct Input {
        let loader: AnyPublisher<Void, Never>
    }
    
    // Output
    final class Output: ObservableObject {
        @Published var pairName = ""
        @Published var price = ""
        @Published var priceChange = 0.0
        
        // 24H Low
        @Published var price24H_Low = ""
        // 24H High
        @Published var price24H_High = ""
        // 24H Vol
        @Published var vol24H = ""
        
        // 1W Low
        @Published var price1W_Low = ""
        // 1W High
        @Published var price1W_High = ""
        // 1W Avg Vol
        @Published var avgVol1W = ""
        
        // Graph values
        @Published var array = []
        // Balances values
        
        // recent trades
    }
    
    // MARK: - Init
    
    internal init(
        model: (pair: TradingAssetPair, ticker: Ticker),
        ohlcCase: LoadOHLCDataUseCaseType
    ) {
        self.model = model
        self.ohlcCase = ohlcCase
    }
    
    func transform(_ input: Input) -> Output {
        let model = input.loader.map { self.model }
        
        let output = Output()

        // map input and use cases to output
        
        // ohlc
        ohlcCase.execute(pairKey: self.model.pair.altname)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { result in
                print(result)
                
                output.array = result.array.map({ tickData in
                    
                    guard case .integer(let timeValue) = tickData[0] else { fatalError() }
                    guard case .string(let openValue) = tickData[1] else { fatalError() }
                    guard case .string(let highValue) = tickData[2] else { fatalError() }
                    guard case .string(let lowValue) = tickData[3] else { fatalError() }
                    guard case .string(let closeValue) = tickData[4] else { fatalError() }
                    guard case .string(let vwapValue) = tickData[5] else { fatalError() }
                    guard case .string(let volumeValue) = tickData[6] else { fatalError() }
                    guard case .integer(let countValue) = tickData[7] else { fatalError() }
                    
                    return TickDataStruct(
                        time: timeValue,
                        open: openValue,
                        high: highValue,
                        low: lowValue,
                        close: closeValue,
                        vwap: vwapValue,
                        volume: volumeValue,
                        count: countValue)
                })
                print(output.array)
            }
            .store(in: &self.cancelBag)
        
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

        // 24H
        model
            .map { $0.ticker.low.first ?? "-" }
            .assign(to: \.price24H_Low, on: output)
            .store(in: &cancelBag)
        
        model
            .map { $0.ticker.high.first ?? "-" }
            .assign(to: \.price24H_High, on: output)
            .store(in: &cancelBag)
        
        model
            .map {
                guard let vol24H = $0.ticker.volume.first else { return "-" }
                return Double(vol24H)?.formattedWithAbbreviations() ?? "-"
            }
            .assign(to: \.vol24H, on: output)
            .store(in: &cancelBag)
        
        // 1W
        model
            .map { $0.ticker.low.last ?? "-" }
            .assign(to: \.price1W_Low, on: output)
            .store(in: &cancelBag)
        
        model
            .map { $0.ticker.high.last ?? "-" }
            .assign(to: \.price1W_High, on: output)
            .store(in: &cancelBag)
        
        model
            .map {
                guard let vol24H = $0.ticker.volume.last else { return "-" }
                return Double(vol24H)?.formattedWithAbbreviations() ?? "-"
            }
            .assign(to: \.avgVol1W, on: output)
            .store(in: &cancelBag)
        
        return output
    }
}
