//
//  KrakenAPIStub.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//


@testable import KrakenDemoApp
import Foundation
import Combine

struct KrakenAPIStub: KrakenAPIType {
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        Just(StubData.shared.pairs)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        Just(StubData.shared.ticker)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getOHLCData(pairKey: String) -> AnyPublisher<TickDataResult, Error> {
        //Fail(error: GenericError()).eraseToAnyPublisher()
        Just(StubData.shared.tickDataResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
