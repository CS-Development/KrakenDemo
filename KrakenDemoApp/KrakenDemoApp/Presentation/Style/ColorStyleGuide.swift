//
//  ColorStyleGuide.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let backgroundFields = Color("BackgroundFieldsColor")
    let primary = Color("PrimaryColor")
    let secondary = Color("SecondaryColor")
    let yellow = Color("YellowColor")
    let primaryText = Color("PrimaryTextColor")
    let secondaryText = Color("SecondaryTextColor")
    
    let green = Color.green
    let red = Color.red
}
