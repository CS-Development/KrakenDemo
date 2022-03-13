//
//  KrakenHomeViewModelTests.swift
//  KrakenDemoAppTests
//
//  Created by Christian Slanzi on 13.03.22.
//

@testable import KrakenDemoApp
import XCTest
import Combine

class KrakenHomeViewModelTests: XCTestCase {
    
    private var viewModel: KrakenHomeViewModel!
    private var pairsCase: LoadTradingAssetPairsUseCaseMock!
    private var tickerCase: LoadTickerUseCaseMock!
    
    private var input: KrakenHomeViewModel.Input!
    private var output: KrakenHomeViewModel.Output!
    private var reloadTrigger = PassthroughSubject<Void, Never>()
    private var selectPair = PassthroughSubject<PairCellViewModel, Never>()

    private var cancelBag: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        pairsCase = LoadTradingAssetPairsUseCaseMock()
        tickerCase = LoadTickerUseCaseMock()
        viewModel = KrakenHomeViewModel(
            pairsCase: pairsCase,
            tickerCase: tickerCase)
        input = KrakenHomeViewModel.Input(
            reloadTrigger: reloadTrigger.eraseToAnyPublisher(),
            selectPair: selectPair.eraseToAnyPublisher())
        cancelBag = Set<AnyCancellable>()
        output = viewModel.transform(input)
    }

    override func tearDownWithError() throws {

    }

}

extension KrakenHomeViewModelTests {
    
    func test_reloadTrigger_getPairs() {
        // act
        reloadTrigger.send(())
        
        // assert
        wait {
            XCTAssert(self.pairsCase.executeCalled)
            XCTAssertEqual(self.output.pairs.count, 1)
        }
    }
    
    func test_reloadTrigger_failed_showError() {
        // arrange
        pairsCase.executeReturnValue = .failure(TestError())
        
        // act
        reloadTrigger.send(())
        
        // assert
        wait {
            XCTAssert(self.pairsCase.executeCalled)
            // TODO
            // XCTAssert(self.output.alert.isShowing)
        }
    }
}
