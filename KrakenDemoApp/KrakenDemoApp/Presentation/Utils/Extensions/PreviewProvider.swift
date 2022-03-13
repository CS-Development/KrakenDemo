//
//  PreviewProvider.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    var lowStatModel: StatisticModel!
    var hiStatModel: StatisticModel!
    var volStatModel: StatisticModel!
    
    var pair: TradingAssetPair!
    var ticker: Ticker!
    
    static let instance = DeveloperPreview()
    private init() {
        lowStatModel = StatisticModel(
            title: "24H Low",
            value: "2,525.21"
        )
        hiStatModel = StatisticModel(
            title: "24H High",
            value: "2,676.89"
        )
        volStatModel = StatisticModel(
            title: "24H Vol",
            value: "34,678"
        )
        
        pair = TradingAssetPair(
            altname: "BTCUSD", wsname: "BTCUSD", aclassBase: "", base: "",
            aclassQuote: "", quote: "", lot: "",
            pairDecimals: 2, lotDecimals: 2, lotMultiplier: 2,
            leverageBuy: [], leverageSell: [],
            fees: [], feesMaker: [],
            feeVolumeCurrency: "", marginCall: 0, marginStop: 0, ordermin: "500"
        )
        
        ticker = Ticker(
            ask: ["42000.00", "42000.00"], bid: ["42000.00", "42000.00"], lastTrade: ["42021.00", "42000.00"],
            volume: ["420.00", "470.00"], volumeWeightedAverage: ["42000.00", "42000.00"], numberOfTrades: [500],
            low: ["42000.00", "42000.00"], high: ["42000.00", "42000.00"], opening: "40000.00"
        )
    }
}
