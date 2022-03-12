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
        
        let vm = PairDetailsViewModel(model: model)
        return PairDetailsView(viewModel: vm)
    }
}
