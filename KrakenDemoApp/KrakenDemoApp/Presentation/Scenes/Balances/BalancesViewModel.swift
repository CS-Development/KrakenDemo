//
//  BalancesViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class BalancesViewModel: ObservableObject {

    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    struct Input {
    }
    
    // Output
    final class Output: ObservableObject {
    }
    
    // MARK: - Init
    
//    init(useCase: UseCaseType) {
//        self.useCase = useCase
//    }
    
    func transform(_ input: Input) -> Output {
        
        let output = Output()

        // TODO: - map input and use cases to output

        return output
    }
}
