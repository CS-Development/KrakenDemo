//
//  TabViewProvider.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

protocol TabViewProviderType {
    var tabName: String { get }
    var systemImageName: String { get }
    var viewProvider: () -> AnyView { get }
}

public class TabViewProvider: TabViewProviderType {
    let tabName: String
    let systemImageName: String
    let viewProvider: () -> AnyView
    
    public required init(
        tabName: String,
        systemImageName: String,
        viewProvider: @escaping () -> AnyView
    ) {
        self.tabName = tabName
        self.systemImageName = systemImageName
        self.viewProvider = viewProvider
    }
}
