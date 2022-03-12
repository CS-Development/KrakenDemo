//
//  KrakenHomeViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class KrakenHomeViewModel: ObservableObject {

    @Published var navigationDirection: NavigationDirection?
    
    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    struct Input {
        var selectPair: AnyPublisher<Void, Never>? = nil
    }
    
    // Output
    final class Output: ObservableObject {
    }
    
    // MARK: - Init
    
//    init(useCase: UseCaseType) {
//        self.useCase = useCase
//    }
    
    // MARK: - Input/Output redux transform
    
    func transform(_ input: Input) -> Output {
        
        let output = Output()

        // map input and use cases to output
        input.selectPair?
            .sink(receiveValue: { _ in
                print("pair was selected")
                self.navigationDirection = .forward(destination: .pairDetails, style: .push)
            })
            .store(in: &cancelBag)

        return output
    }
}
