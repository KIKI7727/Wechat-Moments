//
//  commentView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/8.
//

import SwiftUI
import Foundation

struct RandomItem: Identifiable {
    var id:UUID = UUID()
    var text: String
    var createTime: Date = Date()
}




struct commentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct commentView_Previews: PreviewProvider {
    static var previews: some View {
        commentView()
    }
}
