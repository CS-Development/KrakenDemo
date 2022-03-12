//
//  AppCompositionRoot.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

final public class AppCompositionRoot {
    
    static let assembler: Assembler = DefaultAssembler()
            
    public static var start: some View {
        return TabBar(tabProviders: [
            assembler.resolve(KrakenHomeTabViewProvider.self),
            assembler.resolve(TradeTabViewProvider.self),
            assembler.resolve(BalancesTabViewProvider.self),
            assembler.resolve(AccountTabViewProvider.self)
        ])
    }
}
