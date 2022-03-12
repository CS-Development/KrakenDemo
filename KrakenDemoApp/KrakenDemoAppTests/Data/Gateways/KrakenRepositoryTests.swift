//
//  KrakenRepositoryTests.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import XCTest

class KrakenRepositoryTests: XCTestCase {
    
    var mockRepository: KrakenRepositoryType!
    var stubRepository: KrakenRepositoryType!
    var mockApiClient: KrakenAPIType!
    var stubApiClient: KrakenAPIType!

    override func setUpWithError() throws {
        mockApiClient = KrakenAPIMock()
        stubApiClient = KrakenAPIStub()
        mockRepository = KrakenRepository(apiClient: stubApiClient)
        stubRepository = KrakenRepositoryStub()
    }

    override func tearDownWithError() throws {
        mockApiClient = nil
        mockRepository = nil
        stubRepository = nil
    }
}

extension KrakenRepositoryTests {
    func test_getTradableAssetsPairs_returnsResponse() {
        let expectation = XCTestExpectation(description: "getTradableAssetsPairs")
        
        _ = mockRepository
            .getTradableAssetsPairs()
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTradableAssetsPairs_returnsNotEmptyResponse() {
        let expectation = XCTestExpectation(description: "getTradableAssetsPairs")
        
        _ = mockRepository
            .getTradableAssetsPairs()
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertTrue(!response.isEmpty)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTickerInformation_returnsResponse() {
        let expectation = XCTestExpectation(description: "getTickerInformation")
        
        _ = mockRepository
            .getTickerInformation(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTickerInformation_returnsNotEmptyResponse() {
        let expectation = XCTestExpectation(description: "getTickerInformation")
        
        _ = mockRepository
            .getTickerInformation(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertTrue(!response.isEmpty)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getOHLCData_returnsResponse() {
        let expectation = XCTestExpectation(description: "getOHLCData")
        
        _ = mockRepository
            .getOHLCData(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
}
