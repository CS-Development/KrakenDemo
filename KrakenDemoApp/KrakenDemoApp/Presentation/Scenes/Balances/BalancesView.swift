//
//  BalancesView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct BalancesView: View {
    
    @ObservedObject var viewModel: BalancesViewModel
    @ObservedObject var input: BalancesViewModel.Input
    @ObservedObject var output: BalancesViewModel.Output
    
    init(viewModel: BalancesViewModel) {
        let input = BalancesViewModel.Input()
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
        self.input = input
    }
    
    var body: some View {
        Text("Balances View")
    }
}

struct BalancesView_Previews: PreviewProvider {
    static var previews: some View {
        BalancesView(viewModel: BalancesViewModel())
    }
}
