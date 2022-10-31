//
//  TimelineContentViewModel.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/26.
//

import Foundation
import Combine

    
class TimelineContentViewModel: ObservableObject{
    @Published var timeLinecontent: [Moment] = []
    
    private var subscription: Set<AnyCancellable> = []
    
    init(){
        self.getMyTimelineContent()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
            }){ value in
                self.timeLinecontent = value
            }
            .store(in: &subscription)
    }
    
    
    
    func getMyTimelineContent() -> AnyPublisher <Array<Moment>, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://emagrorrim.github.io/mock-api/moments.json")!)
            .map { $0.data }
            .tryMap {
                try JSONDecoder().decode([Moment].self, from: $0)
            }
            .compactMap{$0}
            .eraseToAnyPublisher()
    }
}

final class TimelineContentItemViewModel: ObservableObject {
    @Published var moment: Moment
    
    init(_ moment: Moment) {
        self.moment = moment
    }
}
