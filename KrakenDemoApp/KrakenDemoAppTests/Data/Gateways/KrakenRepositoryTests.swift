//
//  KrakenRepositoryTests.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 12.03.22.
//

@testable import KrakenDemoApp
import XCTest

class KrakenRepositoryTests: XCTestCase {
    
    var sut: KrakenRepositoryType!
    
    var mockApiClient: KrakenAPIType!
    var stubApiClient: KrakenAPIType!

    override func setUpWithError() throws {
        mockApiClient = KrakenAPIMock()
        stubApiClient = KrakenAPIStub()
        sut = KrakenRepository(apiClient: stubApiClient)
    }

    override func tearDownWithError() throws {
        mockApiClient = nil
        sut = nil
    }
}

extension KrakenRepositoryTests {
    func test_getTradableAssetsPairs_returnsResponse() {
        let expectation = XCTestExpectation(description: "getTradableAssetsPairs")
        
        _ = sut
            .getTradableAssetsPairs()
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTradableAssetsPairs_returnsNotEmptyResponse() {
        let expectation = XCTestExpectation(description: "getTradableAssetsPairs")
        
        _ = sut
            .getTradableAssetsPairs()
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertTrue(!response.isEmpty)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTickerInformation_returnsResponse() {
        let expectation = XCTestExpectation(description: "getTickerInformation")
        
        _ = sut
            .getTickerInformation(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTickerInformation_returnsNotEmptyResponse() {
        let expectation = XCTestExpectation(description: "getTickerInformation")
        
        _ = sut
            .getTickerInformation(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertTrue(!response.isEmpty)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_getOHLCData_returnsResponse() {
        let expectation = XCTestExpectation(description: "getOHLCData")
        
        _ = sut
            .getOHLCData(pairKey: "BTCUSD")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
}
