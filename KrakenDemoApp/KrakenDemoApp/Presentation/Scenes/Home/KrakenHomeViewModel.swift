//
//  KrakenHomeViewModel.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

final class KrakenHomeViewModel: ObservableObject {

    @Published var navigationDirection: NavigationDirection?
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .name
    @Published var isLoading: Bool = false
    
    public let pairsCase: LoadTradingAssetPairsUseCaseType
    public let tickerCase: LoadTickerUseCaseType
    public var selectedPair: String? = nil
    
    private let timer = Timer.publish(
            every: 60, tolerance: 0.5,
            on: .main, in: .common
        )
        .autoconnect()
        //.merge(with: Just(Date()))
    private var cancelBag = Set<AnyCancellable>()
    
    enum SortOption {
        case name, nameReversed, volume, volumeReversed, price, priceReversed
    }
    
    // MARK: -  Input
    struct Input {
        let reloadTrigger: AnyPublisher<Void, Never>
        var selectPair: AnyPublisher<PairCellViewModel, Never>? = nil
    }
    
    // MARK: -  Output
    final class Output: ObservableObject {
        @Published public var sourcePairs: [String : TradingAssetPair] = [:]
        @Published public var pairs: [String : TradingAssetPair] = [:]
        @Published public var tickers: [String : Ticker] = [:]
        @Published public var myList = [ListItem<String, TradingAssetPair>]()
        @Published public var myTickers = [ListItem<String, Ticker>]()
    }
    
    // MARK: - Init
    
    init(pairsCase: LoadTradingAssetPairsUseCaseType, tickerCase: LoadTickerUseCaseType) {
        self.pairsCase = pairsCase
        self.tickerCase = tickerCase
    }
    
    // MARK: - Input/Output redux transform
    
    func transform(_ input: Input) -> Output {
        
        let output = Output()

        $searchText
            .combineLatest(output.$sourcePairs, $sortOption)
            .eraseToAnyPublisher()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{self.filterAndSortPairs(text: $0, pairs: $1, sort: $2, output: output)}
            .sink { pairs in
                output.pairs = pairs
            }
            .store(in: &cancelBag)
        
        // map input and use cases to output
        self.pairsCase.execute()
            .sink { completion in
                // TODO
            } receiveValue: { pairs in
                output.sourcePairs = pairs
                output.pairs = pairs
                self.refreshTickers(output: output)
            }
            .store(in: &self.cancelBag)
        
        timer.sink { _ in
            self.refreshTickers(output: output)
        }
        .store(in: &cancelBag)
        
        input.reloadTrigger.sink { _ in
            self.refreshTickers(output: output)
        }
        .store(in: &cancelBag)
        
        input.selectPair?
            .sink(receiveValue: { cellVm in
                self.selectedPair = cellVm.name
                print("pair \(cellVm.name) was selected")
                self.navigationDirection = .forward(destination: .pairDetails(cellVm: cellVm), style: .push)
            })
            .store(in: &cancelBag)

        return output
    }
    
    private func refreshTickers(output: Output) {
        if self.selectedPair != nil {
            self.tickerCase.execute(pairKey: self.selectedPair!)
                .sink { _ in
                    
                } receiveValue: { tickerDictionary in
                    output.tickers.merge(tickerDictionary) { oldTicker, newTicker in
                        newTicker
                    }
                }
                .store(in: &self.cancelBag)
        } else {
            for pair in output.pairs {
                self.tickerCase.execute(pairKey: pair.key)
                    .sink { _ in
                        
                    } receiveValue: { tickerDictionary in
                        output.tickers.merge(tickerDictionary) { oldTicker, newTicker in
                            newTicker
                        }
                    }
                    .store(in: &self.cancelBag)
            }
        }
    }
    
    private func filterAndSortPairs(text: String, pairs: [String : TradingAssetPair], sort: SortOption, output: Output) -> [String : TradingAssetPair] {
        let updatedPairs = filterPairs(text: text, pairs: pairs)
        sortPairs(pairs: updatedPairs, sort: sort, output: output)
        return updatedPairs
    }
    
    private func sortPairs(pairs: [String : TradingAssetPair], sort: SortOption, output: Output) {
        switch sort {
        case .name:
            let pairs = pairs
            //let tickers = output.tickers
            var myList = [ListItem<String, TradingAssetPair>]()
            for key in pairs.keys.sorted(by: { key1, key2 in
                key1 < key2
            }) {
                myList.append(ListItem(keyObject: key, valueObject: pairs[key]!))
            }
            output.myList = myList
        case .nameReversed:
            let pairs = pairs
            //let tickers = output.tickers
            var myList = [ListItem<String, TradingAssetPair>]()
            for key in pairs.keys.sorted(by: { key1, key2 in
                key1 > key2
            }) {
                myList.append(ListItem(keyObject: key, valueObject: pairs[key]!))
            }
            output.myList = myList
        case .price:
            let pairs = pairs
            let tickers = output.tickers
            let sorted = tickers.sorted {
                return Double($0.value.lastTrade[0])! > Double($1.value.lastTrade[0])!
            }
            var myList = [ListItem<String, TradingAssetPair>]()
            var myTickers = [ListItem<String, Ticker>]()
            for element in sorted {
                if(pairs[element.key] != nil && tickers[element.key] != nil) {
                    myList.append(ListItem(keyObject: element.key, valueObject: pairs[element.key]!))
                    myTickers.append(ListItem(keyObject: element.key, valueObject: tickers[element.key]!))
                }
            }
            output.myTickers = myTickers
            output.myList = myList
        case .priceReversed:
            let pairs = pairs
            let tickers = output.tickers
            let sorted = tickers.sorted {
                return Double($0.value.lastTrade[0])! < Double($1.value.lastTrade[0])!
            }
            var myList = [ListItem<String, TradingAssetPair>]()
            var myTickers = [ListItem<String, Ticker>]()
            for element in sorted {
                if(pairs[element.key] != nil && tickers[element.key] != nil) {
                    myList.append(ListItem(keyObject: element.key, valueObject: pairs[element.key]!))
                    myTickers.append(ListItem(keyObject: element.key, valueObject: tickers[element.key]!))
                }
            }
            output.myTickers = myTickers
            output.myList = myList
        case .volume:
            let pairs = pairs
            let tickers = output.tickers
            let sorted = tickers.sorted {
                return Double($0.value.volume[0])! > Double($1.value.volume[0])!
            }
            var myList = [ListItem<String, TradingAssetPair>]()
            var myTickers = [ListItem<String, Ticker>]()
            for element in sorted {
                if(pairs[element.key] != nil && tickers[element.key] != nil) {
                    myList.append(ListItem(keyObject: element.key, valueObject: pairs[element.key]!))
                    myTickers.append(ListItem(keyObject: element.key, valueObject: tickers[element.key]!))
                }
            }
            output.myTickers = myTickers
            output.myList = myList
        case .volumeReversed:
            let pairs = pairs
            let tickers = output.tickers
            let sorted = tickers.sorted {
                return Double($0.value.volume[0])! < Double($1.value.volume[0])!
            }
            var myList = [ListItem<String, TradingAssetPair>]()
            var myTickers = [ListItem<String, Ticker>]()
            for element in sorted {
                if(pairs[element.key] != nil && tickers[element.key] != nil) {
                    myList.append(ListItem(keyObject: element.key, valueObject: pairs[element.key]!))
                    myTickers.append(ListItem(keyObject: element.key, valueObject: tickers[element.key]!))
                }
            }
            output.myTickers = myTickers
            output.myList = myList
        }
    }
    
    private func filterPairs(text: String, pairs: [String : TradingAssetPair]) -> [String : TradingAssetPair] {
        guard !text.isEmpty else {
            return pairs
        }
        
        let lowercasedText = text.alphaNumeric().lowercased()
        
        return pairs.filter { (pair) -> Bool in
            return pair.key.lowercased().contains(lowercasedText)
        }
    }
}
