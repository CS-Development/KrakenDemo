//
//  TabBarItem.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct TabBarItem: View {
    let tabName: String
    let systemImageName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImageName)
            Text(tabName)
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(tabName: "Home", systemImageName: "house")
    }
}
