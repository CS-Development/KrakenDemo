//
//  ContentView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI
import Combine

struct KrakenHomeView: View {
    
    // MARK: ViewModel output
    @ObservedObject var viewModel: KrakenHomeViewModel
    @ObservedObject var output: KrakenHomeViewModel.Output
    
    // MARK: Input Drivers
    private let reload = PassthroughSubject<Void, Never>()
    private let selectPair = PassthroughSubject<PairCellViewModel, Never>()
    
    // MARK: Init
    init(viewModel: KrakenHomeViewModel) {
        let input = KrakenHomeViewModel.Input(
            reloadTrigger: reload.eraseToAnyPublisher(),
            selectPair: selectPair.eraseToAnyPublisher()
        )
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
    }
    
    // MARK: body
    var body: some View {
        
        return NavigationView {
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                sortingBar
                allPairsList
                    .onAppear {
                        // reset selected pair
                        viewModel.selectedPair = nil
                    }
                .refreshable { reload.send() }
                .handleNavigation($viewModel.navigationDirection)
                .navigationBarHidden(true)
            }
        }
        
    }
    
}

// MARK: subviews
extension KrakenHomeView {
    private var allPairsList: some View {
        
        let tickers = output.tickers
        
        return List(output.myList, id: \.self) { listItem in
            let ticker: Ticker? = tickers[listItem.keyObject]
            let cellViewModel = PairCellViewModel(model: (listItem.valueObject, ticker))
            Button(action: {
               self.selectPair.send(cellViewModel)
            }) {
               PairCellView(viewModel: cellViewModel)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var sortingBar: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Pair")
                Image(systemName: "chevron.down")
                    .opacity( (viewModel.sortOption == .name || viewModel.sortOption == .nameReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .name ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .name ? .nameReversed : .name
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Volume")
                Image(systemName: "chevron.down")
                    .opacity( (viewModel.sortOption == .volume || viewModel.sortOption == .volumeReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .volume ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .volume ? .volumeReversed : .volume
                }
            }
            
            Spacer()

            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity( (viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

// MARK: preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        KrakenHomeView(viewModel: KrakenHomeViewModel(pairsCase: LoadTradingAssetPairsUseCase(), tickerCase: LoadTickerUseCase()))
//    }
//}
