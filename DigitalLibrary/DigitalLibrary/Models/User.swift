//
//  User.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var password: String
    var books: [Book] = []
}