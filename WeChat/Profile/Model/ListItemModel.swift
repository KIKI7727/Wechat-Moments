//
//  ListItemModel.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import Foundation


struct ListItemModel: Identifiable {
    let icon: String
    let title: String
    var id: String {
        return title
    }
}
