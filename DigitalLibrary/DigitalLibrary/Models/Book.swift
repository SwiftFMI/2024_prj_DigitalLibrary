//
//  Book.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct Book: Codable, Hashable {
    let id: String
    let title: String
    let description: String
    let author: String
    let publisher: String
    let year: Int
    let genre: String?
    let returningDeadline: Date?
    let photo: Data?

//    let qrcode: String? // don't know how to configure it, so for it will be nil
//    let isbn: String? // don't know how to configure it, so for it will be nil

    var isTaken: Bool = false

    init(id: String? = nil,
         title: String,
         description: String,
         author: String,
         publisher: String,
         year: Int,
         genre: String? = nil,
         returningDeadline: Date? = nil,
         photo: Data? = nil) {
        if let id {
            self.id = id
        } else {
            self.id = UUID().uuidString
        }
        self.title = title
        self.description = description
        self.author = author
        self.publisher = publisher
        self.year = year
        self.genre = genre
        self.returningDeadline = returningDeadline
        self.photo = photo
    }
}
