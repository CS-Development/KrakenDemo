//
//  UIApplication.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 13.03.22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
