//
//  User.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 13/03/23.
//

import Foundation

struct User {
    var identifier: UUID
    var firstName: String
    var lastName: String
    var companyName: String
    var address: String
    var city: String
    var country: String
    var state: String
    var zip: String
    var phone: String
    var phone1: String
    var email: String
    
    init() {
        self.identifier = UUID()
        self.firstName = ""
        self.lastName = ""
        self.companyName = ""
        self.address = ""
        self.city = ""
        self.country = ""
        self.state = ""
        self.zip = ""
        self.phone = ""
        self.phone1 = ""
        self.email = ""
    }
    
    init(user: [String]) {
        self.identifier = UUID()
        self.firstName = user[0]
        self.lastName = user[1]
        self.companyName = user[2]
        self.address = user[3]
        self.city = user[4]
        self.country = user[5]
        self.state = user[6]
        self.zip = user[7]
        self.phone = user[9]
        self.phone1 = user[8]
        self.email = user[10]
    }
}
