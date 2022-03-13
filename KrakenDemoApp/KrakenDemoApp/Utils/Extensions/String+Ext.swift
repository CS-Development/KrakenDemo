//
//  String+Ext.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

extension String {
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension String {
    internal func alphaNumeric() -> String {
        let pattern = "[^A-Za-z0-9]+"
        return self.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
    }
}
