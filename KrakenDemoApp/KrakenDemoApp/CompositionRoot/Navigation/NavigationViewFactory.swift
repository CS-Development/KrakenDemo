//
//  NavigationViewFactory.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

class NavigationViewFactory {
    
    let assembler: Assembler = DefaultAssembler()

    @ViewBuilder
    func makeView(_ destination: NavigationDestination) -> some View {
        switch destination {
        case .home:
            Text("")
        case .pairDetails(let cellVm):
            if let ticker = cellVm.model.ticker {
                let model = (pair: cellVm.model.pair, ticker: ticker)
                assembler.resolve(model: model, PairDetailsView.self)
            }
        }
    }
}
