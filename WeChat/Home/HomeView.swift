//
//  HomeView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectionTab: HomeTab = .exploration
    
    var body: some View {
        TabView(selection: $selectionTab) {
            Text("微信页面")
                .tabItem {
                    Label("微信", systemImage: "message.fill")
                }
                .tag(HomeTab.chat)
            Text("通讯录页面")
                .tabItem {
                    Label("通讯录", systemImage: "phone.fill")
                }
                .tag(HomeTab.addressList)
            ExplorationView()
                .tabItem {
                    Label("发现", systemImage: "safari.fill")
                }
                .tag(HomeTab.exploration)
            ProfileView()
                .tabItem {
                    Label("我", systemImage: "person.fill")
                }
                .tag(HomeTab.me)
        }
    }
}
enum HomeTab {
    case chat
    case addressList
    case exploration
    case me
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
