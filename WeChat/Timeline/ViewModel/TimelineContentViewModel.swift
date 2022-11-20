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
    @Published var errorMessage: String?
    @Published var isLoading: LoadingState = .Loading
    @Published var index: Int = 5
     

    var refreshSubject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    let maxRow: Int = 5
    
    private var subscription: Set<AnyCancellable> = []
    
    
    init(){
        self.getMyTimelineContent()
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] value in
                self?.timeLinecontent = value.filter { $0.isValid() }
                
            }
            .store(in: &cancellables)

        refreshSubject
            .sink { [weak self] _ in
                self?.errorMessage = nil
                self?.isLoading = .Loading
                self?.index = 5
            }
            .store(in: &cancellables)
    }
    
    
    func isLoadingMore(_ i: Int) {
        if i == self.index - 1 {
            DispatchQueue.main.async {
                self.isLoading = .LoadMore
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                if self.index + 5 > self.timeLinecontent.count {
                    self.index = self.timeLinecontent.count
                } else {
                    self.index += 5
                }
                self.isLoading = .LoadComplete
            })
        }
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
