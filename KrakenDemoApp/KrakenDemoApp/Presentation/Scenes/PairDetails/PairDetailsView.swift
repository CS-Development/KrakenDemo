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
    private let fetcher = PassthroughSubject<Void, Never>()
    
    @ObservedObject var viewModel: PairDetailsViewModel
    @ObservedObject var output: PairDetailsViewModel.Output
    
    init(viewModel: PairDetailsViewModel) {
        let input = PairDetailsViewModel.Input(
            loader: loader.eraseToAnyPublisher(),
            fetcher: fetcher.eraseToAnyPublisher()
        )
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
        loader.send(())
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    overviewSection
                    stats24H_1W
                    Spacer()
                }
                .padding()
                Spacer()
            }
            
            Divider()
            
            Button {
                fetcher.send(())
            } label: {
                Text("Show Graph")
            }
            .modifier(DefaultButton())
            .padding()
            

            if !output.array.isEmpty {
                ChartView(tickDatas: output.array as! [TickDataStruct])
                    .padding(.vertical)
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
    
    private var stats24H_1W: some View {
        HStack {
            HiLoVolStatisticView(
                lowStatModel: StatisticModel(
                    title: "24H Low",
                    value: output.price24H_Low
                ),
                hiStatModel: StatisticModel(
                    title: "24H High",
                    value: output.price24H_High
                ),
                volStatModel: StatisticModel(
                    title: "24H Vol",
                    value: output.vol24H
                )
            )
            Spacer()
            HiLoVolStatisticView(
                lowStatModel: StatisticModel(
                    title: "1W Low",
                    value: output.price1W_Low
                ),
                hiStatModel: StatisticModel(
                    title: "1W High",
                    value: output.price1W_High
                ),
                volStatModel: StatisticModel(
                    title: "1W Avg Vol",
                    value: output.avgVol1W
                )
            )
        }
    }
}

//struct PairDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PairDetailsView(viewModel: PairDetailsViewModel(model: (pair: TradingAssetPair, ticker: Ticker)))
//    }
//}
