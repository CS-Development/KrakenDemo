//
//  KrakenAPI.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

protocol KrakenAPIType {

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
        
}
