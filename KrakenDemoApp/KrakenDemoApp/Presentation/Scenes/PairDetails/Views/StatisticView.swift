//
//  StatisticView.swift
//  KrakenCombineFeedback
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        
        return HStack() {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            Text(stat.value)
                .font(.subheadline)
                .foregroundColor(Color.theme.primaryText)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.lowStatModel)
    }
}
