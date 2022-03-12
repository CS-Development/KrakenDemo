//
//  HiLoVolStatisticView.swift
//  KrakenCombineFeedback
//
//  Created by Christian Slanzi on 12.03.22.
//

import SwiftUI

struct HiLoVolStatisticView: View {
    
    let lowStatModel: StatisticModel
    let hiStatModel: StatisticModel
    let volStatModel: StatisticModel
    
    var body: some View {
        VStack {
            StatisticView(stat: lowStatModel)
            Divider()
            StatisticView(stat: hiStatModel)
            Divider()
            StatisticView(stat: volStatModel)
        }
    }
}

struct HiLoVolStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HiLoVolStatisticView(
            lowStatModel: dev.lowStatModel,
            hiStatModel: dev.hiStatModel,
            volStatModel: dev.volStatModel)
    }
}
