//
//  MainListViewModel.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 13/03/23.
//

import Foundation
import Combine

final class MainListViewModel: ObservableObject {
    @Published var users: [User] = []
    let userService = UserService()
    var subscribers = Set<AnyCancellable>()
    
    init() {
        userService.get().sink { completion in
            switch completion {
                case .failure(let error): print("error: \(error.localizedDescription)")
                case .finished: break
            }
        } receiveValue: { [weak self] (users) in
            
            self?.users = users
        }
        .store(in: &subscribers)
    }
}
