//
//  TimelineView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/25.
//

import SwiftUI

struct TimelineView: View {
@StateObject private var viewModel: TimelineContentViewModel = .init()
    
    var body: some View {
            List {
                TimelineHeaderView(nickname: "", profileImageName: "images", backgroundImageName: "background")
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                if viewModel.timeLinecontent.count > 0 {
                    ForEach( Array(viewModel.timeLinecontent[0..<viewModel.index].enumerated()), id: \.offset) { index, data in
                        TimelineContentItemView(data)
                            .padding(.vertical, 15)
                            .onAppear {
                                // 判断是否显示到最后的cell
                                viewModel.isLoadingMore(index)
                               
                            }
                    }
                    .listRowSeparator(.hidden)
                }
                LoadingIndicator(style: viewModel.isLoading)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .ignoresSafeArea(edges: .top)
            .listStyle(.plain)
            .navigationBarTitle("朋友圈")
            .refreshable {
                // 上拉刷新
                viewModel.refreshSubject.send()
            }
        }
    }
struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
