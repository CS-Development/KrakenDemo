//
//  KrakenHomeViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class KrakenHomeViewModel: ObservableObject {

    private var cancelBag = Set<AnyCancellable>()
    
    // Input
    final class Input: ObservableObject {
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
