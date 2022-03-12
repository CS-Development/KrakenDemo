//
//  ContentView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI
import Combine

struct ListItem<Key: Hashable , ValueObject: Hashable>: Hashable {
    let keyObject: Key
    let valueObject: ValueObject
}

struct KrakenHomeView: View {
    
    @ObservedObject var viewModel: KrakenHomeViewModel
    @ObservedObject var output: KrakenHomeViewModel.Output
    
    private let selectPair = PassthroughSubject<PairCellViewModel, Never>()
    
    init(viewModel: KrakenHomeViewModel) {
        let input = KrakenHomeViewModel.Input(selectPair: selectPair.eraseToAnyPublisher())
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
    }
    
    var body: some View {
        
        return NavigationView {
            allPairsList
            .handleNavigation($viewModel.navigationDirection)
            .navigationBarHidden(true)
        }
    }
    
}

extension KrakenHomeView {
    private var allPairsList: some View {
        
        let pairs = output.pairs
        let tickers = output.tickers
        var myList = [ListItem<String, TradingAssetPair>]()
        for key in pairs.keys.sorted() {
            myList.append(ListItem(keyObject: key, valueObject: pairs[key]!))
        }
        
        var myTickers = [ListItem<String, Ticker>]()
        for key in tickers.keys.sorted() {
            myTickers.append(ListItem(keyObject: key, valueObject: tickers[key]!))
        }
        
        return List(myList, id: \.self) { listItem in
            let ticker: Ticker? = tickers[listItem.keyObject]
            let cellViewModel = PairCellViewModel(model: (listItem.valueObject, ticker))
            Button(action: {
               self.selectPair.send(cellViewModel)
            }) {
               PairCellView(viewModel: cellViewModel)
            }
        }
        //.listStyle(PlainListStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        KrakenHomeView(viewModel: KrakenHomeViewModel(pairsCase: LoadTradingAssetPairsUseCase(), tickerCase: LoadTickerUseCase()))
//    }
//}
