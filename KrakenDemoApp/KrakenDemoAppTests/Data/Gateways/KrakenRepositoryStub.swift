//
//  KrakenRepositoryStub.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import Foundation
import Combine

final class KrakenRepositoryStub: KrakenRepositoryType {
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        return Just(StubData.shared.pairs)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        return Just(StubData.shared.ticker)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getOHLCData(pairKey: String) -> AnyPublisher<TickDataResult, Error> {
        return Just(StubData.shared.tickDataResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
}
