//
//  StubData.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import Foundation

class StubData {
    
    static var shared = StubData()
    
    let pairs = ["BTCUSD" : TradingAssetPair(altname: "BTCUSD", wsname: "BTCUSD", aclassBase: "", base: "", aclassQuote: "", quote: "", lot: "", pairDecimals: 2, lotDecimals: 2, lotMultiplier: 1, leverageBuy: [], leverageSell: [], fees: [[]], feesMaker: [[]], feeVolumeCurrency: "", marginCall: 0, marginStop: 0, ordermin: "1")]
    
    let ticker = ["BTCUSD" : Ticker(ask: [], bid: [], lastTrade: [], volume: [], volumeWeightedAverage: [], numberOfTrades: [], low: [], high: [], opening: "")]
    
    let tickDataResult = TickDataResult(array: [[]])
}
