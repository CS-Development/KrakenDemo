//
//  ContentView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI
import Combine

struct KrakenHomeView: View {
    
    @ObservedObject var viewModel: KrakenHomeViewModel
    @ObservedObject var input: KrakenHomeViewModel.Input
    @ObservedObject var output: KrakenHomeViewModel.Output
    
    init(viewModel: KrakenHomeViewModel) {
        let input = KrakenHomeViewModel.Input()
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
        self.input = input
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KrakenHomeView(viewModel: KrakenHomeViewModel())
    }
}
