//
//  LoadTradingAssetPairsUseCaseMock.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 13.03.22.
//

@testable import KrakenDemoApp
import Combine

final class LoadTradingAssetPairsUseCaseMock: LoadTradingAssetPairsUseCaseType {
    
    var executeCalled = false
    var executeReturnValue = Result<[String : TradingAssetPair], Error>.success(StubData.shared.pairs)
    
    // MARK: - loadTradingAssetPairs
    
    func execute() -> AnyPublisher<[String : TradingAssetPair], Error> {
        executeCalled = true
        return executeReturnValue.publisher.eraseToAnyPublisher()
    }
    
}
