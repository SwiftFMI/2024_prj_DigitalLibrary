//
//  User.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    var readingBooks: [String: Book]? = [:]
    var unfinishedBooks: [String: Book]? = [:]
    var readBooks: [String: Book]? = [:]
}
