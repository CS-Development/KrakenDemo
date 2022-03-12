//
//  KrakenRepositoryMock.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import Foundation
import Combine

final class KrakenRepositoryMock: KrakenRepositoryType {
    
    var getTradableAssetsPairsCalled = false
    var getTradableAssetsPairsReturnValue: Result<[String : TradingAssetPair], Error> = .success([:])
    
    var getTickerInformationCalled = false
    var getTickerInformationReturnValue: Result<[String : Ticker], Error> = .success([:])
    
    var getOHLCDataCalled = false
    var getOHLCDataReturnValue: Result<TickDataResult, Error> = .success(TickDataResult(array: [[]]))
    
    // MARK: Api calls
    
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        getTradableAssetsPairsCalled = true
        return getTradableAssetsPairsReturnValue.publisher.eraseToAnyPublisher()
    }
    
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        getTickerInformationCalled = true
        return getTickerInformationReturnValue.publisher.eraseToAnyPublisher()
    }
    
    func getOHLCData(pairKey: String) -> AnyPublisher<TickDataResult, Error> {
        getOHLCDataCalled = true
        return getOHLCDataReturnValue.publisher.eraseToAnyPublisher()
    }
    
}
    
