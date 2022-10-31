//
//  ProfileHeaderViewModel.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/25.
//

import Foundation
import Combine

class ProfileHeaderViewModel: ObservableObject{
    @Published var profileHeaderUrl: String = ""
    @Published var nickName: String = ""
    @Published var userName: String = ""
    @Published var avatar: String = ""
    
    private var subscription: Set<AnyCancellable> = []
    
    let MyProfileService: myProfileService = myProfileService()
    init(){
        self.MyProfileService.getMyProfileInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}){ value in
                self.profileHeaderUrl = value.profileImage
                self.nickName = value.nick
                self.userName = value.username
                self.avatar = value.avatar
            }
            .store(in: &subscription)
    }

}

//
