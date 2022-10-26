//
//  Profile.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import Foundation
import Combine

struct myProfileInfo: Codable {
    let profileImage: String
    let avatar: String
    let nick:String
    let username: String

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile-image"
        case avatar, nick, username
    }
}


class myProfileService {
    func getMyProfileInfo() -> AnyPublisher <myProfileInfo, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://emagrorrim.github.io/mock-api/user/jsmith.json")!)
            .map { $0.data }
            .tryMap {
                try JSONDecoder().decode(myProfileInfo.self, from: $0)
            }
            .compactMap {$0}
            .eraseToAnyPublisher()
    }
}
