//
//  LoadTradingAssetPairsUseCaseTests.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 13.03.22.
//

@testable import KrakenDemoApp
import XCTest

class LoadTradingAssetPairsUseCaseTests: XCTestCase {
    
    private var krakenRepositoryMock: KrakenRepositoryMock!

    override func setUpWithError() throws {
        krakenRepositoryMock = KrakenRepositoryMock()
    }

    override func tearDownWithError() throws {
        
    }

}

extension LoadTradingAssetPairsUseCaseTests {
    
    func test_getTradableAssetsPairs() {
        // TODO: test we get a valid object back
    }
    
    func test_getTradableAssetsPairs_failed() {
        // TODO: test we get an error if the gateway produce an error
    }
}
