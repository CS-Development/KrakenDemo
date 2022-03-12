//
//  KrakenRepository.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

public protocol KrakenRepositoryType { // a.k.a. gateway
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error>
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error>
    
    func getOHLCData(pairKey: String)-> AnyPublisher<TickDataResult, Error>
}

public struct KrakenRepository: KrakenRepositoryType {
    let apiClient: KrakenAPIType
    
    public func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        return apiClient.getTradableAssetsPairs()
    }
    
    public func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        return apiClient.getTickerInformation(pairKey: pairKey)
    }
    
    public func getOHLCData(pairKey: String)-> AnyPublisher<TickDataResult, Error> {
        return apiClient.getOHLCData(pairKey: pairKey)
    }
}
