//
//  KrakenAPI.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

protocol KrakenAPIType {
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error>
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error>
    func getOHLCData(pairKey: String)-> AnyPublisher<TickDataResult, Error>
}

struct KrakenAPI: KrakenAPIType {
    
    let baseURL = "https://api.kraken.com/0/public"

    var cancelBag = Set<AnyCancellable>()
        
    struct DataResponse<T>: Decodable where T: Decodable {
        public let result: [String: T]
        public let error: [String]
        public var description: String {
            return """
            ------------
            result = \(result)
            error = \(error)
            ------------
            """
        }
    }
    
    struct DataResponseExt<T>: Decodable where T: Decodable {
        public let result: T
        public let error: [String]
        public var description: String {
            return """
            ------------
            result = \(result)
            error = \(error)
            ------------
            """
        }
    }
    
    // MARK: - APIs
    func getTradableAssetsPairs() -> AnyPublisher<[String : TradingAssetPair], Error> {
        let url = URL(string: baseURL)!.appendingPathComponent("AssetPairs")

        let publisher = URLSession.shared.dataTaskPublisher(for: url, cachedResponseOnError: true)
        return publisher
            .handleEvents(
                receiveOutput: { response in
                let httpResponse = response.response as? HTTPURLResponse
                DispatchQueue.global().async {
                    try? CacheManager.sharedInstance.write(urlString: url.absoluteString,
                                                           data: response.data,
                                                           header: httpResponse?.allHeaderFields)
                }
            })
            .map(\.data)
            .replaceError(with: { () -> Data in
                guard let cacheRequest = try? CacheManager.sharedInstance.read(urlString: url.absoluteString) else { return Data() }
                return cacheRequest.0 as! Data
            }())
            .decode(type: DataResponse<TradingAssetPair>.self, decoder: JSONDecoder())
            .print()
            .map{ $0.result }
            
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getTickerInformation(pairKey: String) -> AnyPublisher<[String : Ticker], Error> {
        var url = URL(string: baseURL)!.appendingPathComponent("Ticker")
        url.appendQueryItem(name: "pair", value: pairKey)
        let publisher = URLSession.shared.dataTaskPublisher(for: url, cachedResponseOnError: true)
        return publisher
            .handleEvents(
                receiveOutput: { response in
                let httpResponse = response.response as? HTTPURLResponse
                DispatchQueue.global().async {
                    try? CacheManager.sharedInstance.write(urlString: url.absoluteString,
                                                           data: response.data,
                                                           header: httpResponse?.allHeaderFields)
                }
            })
            .map(\.data)
            .replaceError(with: { () -> Data in
                guard let cacheRequest = try? CacheManager.sharedInstance.read(urlString: url.absoluteString) else { return Data() }
                return cacheRequest.0 as! Data
            }())
            .decode(type: DataResponse<Ticker>.self, decoder: JSONDecoder())
            .print()
            .map{ $0.result }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getOHLCData(pairKey: String) -> AnyPublisher<TickDataResult, Error> {
        var url = URL(string: baseURL)!.appendingPathComponent("OHLC")
        url.appendQueryItem(name: "pair", value: pairKey)
        //url.appendQueryItem(name: "interval", value: "1")
        let publisher = URLSession.shared.dataTaskPublisher(for: url, cachedResponseOnError: true)
        return publisher
            .handleEvents(
                receiveOutput: { response in
                let httpResponse = response.response as? HTTPURLResponse
                DispatchQueue.global().async {
                    try? CacheManager.sharedInstance.write(urlString: url.absoluteString,
                                                           data: response.data,
                                                           header: httpResponse?.allHeaderFields)
                }
            })
            .map(\.data)
            .replaceError(with: { () -> Data in
                guard let cacheRequest = try? CacheManager.sharedInstance.read(urlString: url.absoluteString) else { return Data() }
                return cacheRequest.0 as! Data
            }())
            .decode(type: DataResponseExt<TickDataResult>.self, decoder: JSONDecoder())
            .print()
            .map{ $0.result }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
