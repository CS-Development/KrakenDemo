//
//  KrakenHomeAssembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol KrakenHomeAssembler {
    func resolve(_ type: KrakenHomeTabViewProvider.Type) -> KrakenHomeTabViewProvider
}

class KrakenHomeTabViewProvider: TabViewProvider {}

extension KrakenHomeAssembler {
    func resolve(_ type: KrakenHomeTabViewProvider.Type) -> KrakenHomeTabViewProvider {
        return KrakenHomeTabViewProvider(tabName: "Home",
                     systemImageName: "house") {
            
            let apiClient = KrakenAPI()//KrakenAPIStub()//KrakenAPI()
            let repository = KrakenRepository(apiClient: apiClient)
            let pairsCase = LoadTradingAssetPairsUseCase(krakenRepository: repository)
            let tickerCase = LoadTickerUseCase(krakenRepository: repository)
            
            let viewModel = KrakenHomeViewModel(pairsCase: pairsCase, tickerCase: tickerCase)
            return KrakenHomeView(viewModel: viewModel)
                .erased
        }
    }
}
