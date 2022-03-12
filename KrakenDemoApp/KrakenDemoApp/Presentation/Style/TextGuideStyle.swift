//
//  TextGuideStyle.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

struct Header1: ViewModifier {
    
    func body(content: Content) -> some View {
        content
         
            .font(.system(.largeTitle, design: .serif))
            .foregroundColor(Color.theme.primaryText)
    }
}


struct Header2: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(Color.theme.primaryText)
    }
}

struct Header3: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color.theme.primaryText)
    }
}

struct FootNote: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(Color.theme.primaryText)
    }
}


struct BodyStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(Color.theme.primaryText)
    }
}

struct GrayBodyStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(Color.theme.secondaryText)
    }
}

struct TextStyleGuide: View {
    var body: some View {
        VStack {
          Text("title style")
                .modifier(Header1())
            
            Text("Header 2")
                    .modifier(Header2())
            
            Text("Header 3")
                    .modifier(Header3())
            
            
            Text("Body style")
                    .modifier(BodyStyle())
            
            Text("Gray Body style")
                    .modifier(GrayBodyStyle())
            
            Text("Header 2")
                    .modifier(FootNote())
        }
    }
}

struct TextStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        TextStyleGuide()
    }
}
