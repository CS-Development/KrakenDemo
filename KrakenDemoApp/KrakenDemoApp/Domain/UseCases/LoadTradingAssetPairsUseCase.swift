//
//  LoadTradingAssetPairsUseCase.swift
//  KrakenCombineFeedback
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

public protocol LoadTradingAssetPairsUseCaseType {
    func execute() -> AnyPublisher<[String : TradingAssetPair], Error>
}

public class LoadTradingAssetPairsUseCase: LoadTradingAssetPairsUseCaseType {

    let krakenRepository: KrakenRepositoryType
    
    public init(krakenRepository: KrakenRepositoryType) {
        self.krakenRepository = krakenRepository
    }
    
    // execute request
    public func execute() -> AnyPublisher<[String : TradingAssetPair], Error> {
        return krakenRepository.getTradableAssetsPairs()
    }
    
}
