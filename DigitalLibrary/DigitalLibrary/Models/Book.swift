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
    let genre: String
    let isbn: String
    let returningDeadline: Date?
    let photo: Data?

    var isTaken: Bool = false

    init(id: String? = nil,
         title: String,
         description: String,
         author: String,
         publisher: String,
         year: Int,
         genre: String,
         isbn: String,
         returningDeadline: Date? = nil,
         photo: Data? = nil,
         isTaken: Bool) {
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
        self.isbn = isbn
        self.returningDeadline = returningDeadline
        self.photo = photo
        self.isTaken = isTaken
    }
}
