//
//  AccountAssembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol AccountAssembler {
    func resolve(_ type: AccountTabViewProvider.Type) -> AccountTabViewProvider
}

class AccountTabViewProvider: TabViewProvider {}

extension AccountAssembler {
    func resolve(_ type: AccountTabViewProvider.Type) -> AccountTabViewProvider {
        return AccountTabViewProvider(tabName: "Account",
                             systemImageName: "magnifyingglass") {
            
            return AccountView()
                        .erased
        }
    }
}
