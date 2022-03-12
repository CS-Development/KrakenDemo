//
//  TemplateAssembler.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

protocol TemplateAssembler {
    func resolve(_ type: TemplateTabViewProvider.Type) -> TemplateTabViewProvider
}

class TemplateTabViewProvider: TabViewProvider {}

extension TemplateAssembler {
    func resolve(_ type: TemplateTabViewProvider.Type) -> TemplateTabViewProvider {
        return TemplateTabViewProvider(tabName: "Template",
                             systemImageName: "magnifyingglass") {
            
            return TemplateView()
                        .erased
        }
    }
}
