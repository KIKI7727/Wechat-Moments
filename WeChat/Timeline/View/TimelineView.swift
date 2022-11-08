//
//  TimelineView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/25.
//

import SwiftUI

struct TimelineView: View {
    @StateObject private var viewModel: TimelineContentViewModel = .init()
    @State var commitList: [String] = []
    @State var isShow: Bool = false
    @State var isLikeArrayShow: Bool = false
    
    var body: some View {
        HStack{
            List {
                TimelineHeaderView(nickname: "", profileImageName: "images", backgroundImageName: "background")
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                if viewModel.timeLinecontent.count > 0 {
                    ForEach( Array(viewModel.timeLinecontent[0..<viewModel.index].enumerated()), id: \.offset) { index, data in
                        TimelineContentItemView(isShow: $isShow, moment: data)
                            .padding(.vertical, 15)
                            .onAppear {
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
                viewModel.refreshSubject.send()
            }
        }
//        .inputDialog(isPresented: $isShow, isLike: $isLikeArrayShow, action: { item in
//            if (!item.isEmpty){
//                commitList.append(item)
//                print(commitList)
//            }
//        })
    }
    }
