//
//  AccountView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel
    @ObservedObject var output: AccountViewModel.Output
    
    init(viewModel: AccountViewModel) {
        let input = AccountViewModel.Input()
        
        self.viewModel = viewModel
        self.output = viewModel.transform(input)
    }
    
    var body: some View {
        Text("Account View")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel())
    }
}
