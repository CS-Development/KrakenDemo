//
//  TradingAssetPair.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

public struct TradingAssetPair: Codable, Hashable {

    let altname: String
    let wsname: String?
    let aclassBase: String
    let base: String
    let aclassQuote: String
    let quote: String
    let lot: String
    let pairDecimals, lotDecimals, lotMultiplier: Int
    let leverageBuy, leverageSell: [Int]
    let fees, feesMaker: [[Double]]
    let feeVolumeCurrency: String
    let marginCall, marginStop: Int
    let ordermin: String

    enum CodingKeys: String, CodingKey {
        case altname, wsname
        case aclassBase = "aclass_base"
        case base
        case aclassQuote = "aclass_quote"
        case quote, lot
        case pairDecimals = "pair_decimals"
        case lotDecimals = "lot_decimals"
        case lotMultiplier = "lot_multiplier"
        case leverageBuy = "leverage_buy"
        case leverageSell = "leverage_sell"
        case fees
        case feesMaker = "fees_maker"
        case feeVolumeCurrency = "fee_volume_currency"
        case marginCall = "margin_call"
        case marginStop = "margin_stop"
        case ordermin
    }
    
}
