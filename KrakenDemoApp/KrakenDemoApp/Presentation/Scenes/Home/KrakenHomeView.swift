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
    @ObservedObject var output: KrakenHomeViewModel.Output
    
    private let selectPair = PassthroughSubject<Void, Never>()
    
    init(viewModel: KrakenHomeViewModel) {
        let input = KrakenHomeViewModel.Input(selectPair: selectPair.eraseToAnyPublisher())
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
    }
    
    var body: some View {
        
        return NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
                Button {
                    self.selectPair.send()
                } label: {
                    Text("Go to Pair Details View")
                }
            }
            .handleNavigation($viewModel.navigationDirection)
            .navigationBarHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KrakenHomeView(viewModel: KrakenHomeViewModel())
    }
}
