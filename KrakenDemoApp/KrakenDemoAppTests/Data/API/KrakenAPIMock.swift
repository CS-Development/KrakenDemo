//
//  KrakenAPIMock.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import Foundation
import Combine
import XCTest

struct GenericError: Error {}

struct KrakenAPIMock: KrakenAPIType {
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        Just([ : ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        Just([ : ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getOHLCData(pairKey: String) -> AnyPublisher<TickDataResult, Error> {
        //Fail(error: GenericError()).eraseToAnyPublisher()
        Just(TickDataResult(array: [[]]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
