//
//  TimelineView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/25.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        List {
            TimelineHeaderView(nickname: "", profileImageName: "images", backgroundImageName: "background")
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            TimelineContentView()
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitle("朋友圈")
    }
}
struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
