//
//  PairDetailsView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct PairDetailsView: View {
    
    @ObservedObject var viewModel: PairDetailsViewModel
    @ObservedObject var output: PairDetailsViewModel.Output
    
    init(viewModel: PairDetailsViewModel) {
        let input = PairDetailsViewModel.Input()
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
    }
    
    var body: some View {
        Text("Pair Details")
    }
}

struct PairDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PairDetailsView(viewModel: PairDetailsViewModel())
    }
}
