//
//  PairDetailsView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI
import Combine

struct PairDetailsView: View {
    
    private var cancelBag = Set<AnyCancellable>()
    private let loader = PassthroughSubject<Void, Never>()
    
    @ObservedObject var viewModel: PairDetailsViewModel
    @ObservedObject var output: PairDetailsViewModel.Output
    
    init(viewModel: PairDetailsViewModel) {
        let input = PairDetailsViewModel.Input(loader: loader.eraseToAnyPublisher())
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
        loader.send(())
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    overviewSection
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

extension PairDetailsView {
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(output.pairName)
                .modifier(Header1())
            Text(output.price)
            Text(output.priceChange.asPercentString())
                .foregroundColor(
                    output.priceChange >= 0 ? Color.theme.green : Color.theme.red
                )
        }
    }
}

//struct PairDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PairDetailsView(viewModel: PairDetailsViewModel(model: (pair: TradingAssetPair, ticker: Ticker)))
//    }
//}
