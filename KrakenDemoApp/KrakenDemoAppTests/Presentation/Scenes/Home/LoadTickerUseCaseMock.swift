//
//  LoadTickerUseCaseMock.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 14.03.22.
//

import Foundation

@testable import KrakenDemoApp
import Combine

final class LoadTickerUseCaseMock: LoadTickerUseCaseType {

    var executeCalled = false
    var executeReturnValue = Result<[String : Ticker], Error>.success(StubData.shared.ticker)
    
    // MARK: - loadTradingAssetPairs
    
    func execute(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        executeCalled = true
        return executeReturnValue.publisher.eraseToAnyPublisher()
    }
    
}
