//
//  Assembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol Assembler: AnyObject,
    KrakenHomeAssembler,
    TradeAssembler,
    BalancesAssembler,
    AccountAssembler,
    PairDetailsAssembler {
    
}

final class DefaultAssembler: Assembler {

}
