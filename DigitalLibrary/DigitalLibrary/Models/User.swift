//
//  User.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct UserModel: Codable {
    let id: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var readingBooks: [Book]? = []
    var unfinishedBooks: [Book]? = []
    var readBooks: [Book]? = []
}
