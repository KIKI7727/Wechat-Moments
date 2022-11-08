//
//  TimelineContent.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/27.
//

import Foundation

struct Moment: Codable, Identifiable {
    var id = UUID()
    let content: String?
    let images: [Images]?
    let sender: Sender?
    let comments: [Comments]?
    
    
    enum CodingKeys: CodingKey {
        case content, images, sender, comments
    }
    
    func isValid() -> Bool {
        if content == nil && images == nil {
            return false
        } else {
            return true
        }
    }
}

struct Images: Codable {
    let url: String
}

struct Sender: Codable {
    let username: String
    let nick: String
    let avatar: String
}
struct Comments: Codable {
    //var id = UUID()
    let content: String
    let sender: Sender
}

enum LoadingState: Int {
    case Loading = 0
    case LoadMore = 1
    case LoadComplete = 2
}

