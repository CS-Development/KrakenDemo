//
//  AppCompositionRoot.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

final public class AppCompositionRoot {
            
    public static var start: some View {
        return TabBar(tabProviders: [
            TabViewProvider(tabName: "Home", systemImageName: "house", viewProvider: {
                KrakenHomeView().erased
            }),
            TabViewProvider(tabName: "Trade", systemImageName: "arrow.triangle.2.circlepath", viewProvider: {
                TradeView().erased
            }),
            TabViewProvider(tabName: "Balances", systemImageName: "building.columns", viewProvider: {
                BalancesView().erased
            }),
            TabViewProvider(tabName: "Account", systemImageName: "magnifyingglass", viewProvider: {
                AccountView().erased
            })
        ])
    }
}
