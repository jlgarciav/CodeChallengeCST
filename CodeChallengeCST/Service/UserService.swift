//
//  UserService.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 13/03/23.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func get() -> AnyPublisher<[User], Error>
}

final class UserService: UserServiceProtocol {
    func get() -> AnyPublisher<[User], Error> {
        Future<[User], Error> { promise in
            do {
                let url = Bundle.main.url(forResource: "sample_contacts", withExtension: "csv")!
                let content = try String(contentsOf: url)
                let filteredList: [User] = content.components(
                    separatedBy: "\n"
                )
                    .filter { !$0.isEmpty }
                    .enumerated()
                    .compactMap { (index, value) in
                        guard index != 0 else { return User() }
                        let user = value.components(separatedBy: ",")
                        return User(user: user)
                    }
                    .filter {
                        !$0.firstName.isEmpty && !$0.lastName.isEmpty
                    }
                promise(.success(filteredList))
            }
            catch {
                promise(.failure(error))
            }
        }
        .compactMap { $0 }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
