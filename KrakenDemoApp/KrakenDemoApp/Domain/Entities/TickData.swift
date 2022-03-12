//
//  TickData.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

public struct TickDataResult: Codable {
    let array: [[TickData]]
    //let last: Int
    
    struct DynamicCodingKeys: CodingKey, Hashable {
            var stringValue: String
            
            init(stringValue: String) {
                self.stringValue = stringValue
            }
            
            var intValue: Int? {
                return nil
            }
            
            init?(intValue: Int) {
                return nil
            }
        }
    
    public init(array: [[TickData]]) {
        self.array = array
    }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            let pairs = container.allKeys
            var temparray: [[TickData]] = []
            for pair in pairs {
                if pair.stringValue != "last" {
                    temparray = try container.decode([[TickData]].self, forKey: pair)
                }
                
            }
            array = temparray
        }
}

public enum TickData: Codable, Hashable {
    case integer(Int)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TickData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Xxbtzusd"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
