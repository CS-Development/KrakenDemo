//
//  Ticker.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

public struct Ticker: Codable, Hashable {
    
    let ask: [String]
    let bid: [String]
    let lastTrade: [String]
    let volume: [String]
    let volumeWeightedAverage: [String]
    let numberOfTrades: [Int]
    let low: [String]
    let high: [String]
    let opening: String
    
    enum CodingKeys: String, CodingKey {
        case ask = "a"
        case bid = "b"
        case lastTrade = "c"
        case volume = "v"
        case volumeWeightedAverage = "p"
        case numberOfTrades = "t"
        case low = "l"
        case high = "h"
        case opening = "o"
        /*
         a = ask array(<price>, <whole lot volume>, <lot volume>),
         b = bid array(<price>, <whole lot volume>, <lot volume>),
         c = last trade closed array(<price>, <lot volume>),
         v = volume array(<today>, <last 24 hours>),
         p = volume weighted average price array(<today>, <last 24 hours>),
         t = number of trades array(<today>, <last 24 hours>),
         l = low array(<today>, <last 24 hours>),
         h = high array(<today>, <last 24 hours>),
         o = today's opening price
         */
    }
}
