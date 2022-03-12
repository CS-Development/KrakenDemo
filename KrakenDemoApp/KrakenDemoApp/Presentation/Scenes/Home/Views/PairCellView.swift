//
//  PairCellView.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct PairCellView: View {
    
    let viewModel: PairCellViewModel
    
    init(viewModel: PairCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            Text(viewModel.lastTradeClosed)
        }
    }
}

extension PairCellView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("\(viewModel.name)") //.uppercased()
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryText)
                
                Text("\(viewModel.volumeLast24H)") //.uppercased()
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

//struct PairCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PairCellView(viewModel: PairCellViewModel(model: ))
//    }
//}
