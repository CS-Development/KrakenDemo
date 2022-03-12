//
//  PairCellViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

struct PairCellViewModel {
    let model: (pair: TradingAssetPair, ticker: Ticker?)
    
    var name: String {
        return model.pair.wsname ?? "-"
    }
    
    var volumeLast24H: String {
        guard let vol24H = model.ticker?.volume.last else { return "24H Vol " + "-" }
        return "24H Vol " + (Double(vol24H)?.formattedWithAbbreviations() ?? "-")
    }
    
    var lastTradeClosed: String {
        return model.ticker?.lastTrade.first ?? "-"
    }
}
