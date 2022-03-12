//
//  ButtonStyleGuide.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import SwiftUI

struct DefaultButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }
}

struct ButtonStyleGuide: View {
    
    var body: some View {
        VStack {
            Button { } label: {
                Text("default button")
            }
            .modifier(DefaultButton())

        }
        .frame(width: 200)
    }
}

struct ButtonStyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleGuide()
    }
}
