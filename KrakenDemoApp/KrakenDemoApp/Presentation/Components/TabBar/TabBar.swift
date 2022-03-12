//
//  TabBar.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct TabBar: View {
    
    let tabProviders: [TabViewProvider]
        
    public init(tabProviders: [TabViewProvider]) {
        self.tabProviders = tabProviders
    }
    
    var body: some View {
        TabView {
            ForEach(tabProviders, id: \.tabName) { tabProvider in
                tabProvider.viewProvider()
                    .tabItem {
                        tabBarItem(
                            tabName: tabProvider.tabName,
                            systemImageName: tabProvider.systemImageName
                        )
                    }
            }
            
        }
    }
    
    private func tabBarItem(tabName: String, systemImageName: String) -> some View {
        return TabBarItem(tabName: tabName,
                          systemImageName: systemImageName)
    }

}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(tabProviders: [
            .init(tabName: "First",
                  systemImageName: "house",
                  viewProvider: {
                      AnyView(Text("Fist Tab"))
                  }),
            .init(tabName: "Second",
                  systemImageName: "heart.fill",
                  viewProvider: {
                      AnyView(Text("Second Tab"))
                  })
        ])
    }
}
