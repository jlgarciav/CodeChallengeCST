//
//  UserDetailViewModel.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 14/03/23.
//

import Combine
import UIKit

final class UserDetailViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedUser: User = User()
    
    // MARK: - Im just gonna validate that we have user first name, last name an cellphone data required
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    var isValidFirstName: AnyPublisher<Bool, Never> {
        $firstName
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    var isValidLastName: AnyPublisher<Bool, Never> {
        $lastName
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidPhoneNumber: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest3(isValidFirstName, isValidLastName, isValidPhoneNumber)
                .map { $0 && $1 && $2 }
                .eraseToAnyPublisher()
        }
    
    init() {
        $selectedUser.sink(receiveValue: { [unowned self] user in
            self.firstName = user.firstName
            self.lastName = user.lastName
            self.phoneNumber = user.phone
        }).store(in: &subscriptions)
    }
}
