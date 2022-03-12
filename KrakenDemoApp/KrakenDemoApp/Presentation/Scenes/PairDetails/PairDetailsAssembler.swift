//
//  PairDetailsAssembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol PairDetailsAssembler {
    func resolve(_ type: PairDetailsView.Type) -> PairDetailsView
}


extension PairDetailsAssembler {
    func resolve(_ type: PairDetailsView.Type) -> PairDetailsView {
        let viewModel = PairDetailsViewModel()
        return PairDetailsView(viewModel: viewModel)
    }
}
