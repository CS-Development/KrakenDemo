//
//  PairDetailsAssembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol PairDetailsAssembler {
    func resolve(model: (pair: TradingAssetPair, ticker: Ticker), _ type: PairDetailsView.Type) -> PairDetailsView
}

extension PairDetailsAssembler {
    func resolve(model: (pair: TradingAssetPair, ticker: Ticker), _ type: PairDetailsView.Type) -> PairDetailsView {
        
        let apiClient = KrakenAPI()
        let repository = KrakenRepository(apiClient: apiClient)
        let ohlcCase = LoadOHLCDataUseCase(krakenRepository: repository)
        
        let vm = PairDetailsViewModel(model: model, ohlcCase: ohlcCase)
        return PairDetailsView(viewModel: vm)
    }
}
