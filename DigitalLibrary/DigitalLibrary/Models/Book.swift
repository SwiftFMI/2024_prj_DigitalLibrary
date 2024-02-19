//
//  Book.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct Book: Codable, Hashable, Identifiable {
    var id = UUID().uuidString

    let title: String
    let description: String
    let author: String
    let publisher: String
    let year: Int
    var genre: String? = nil
//    let qrcode: String? // don't know how to configure it, so for it will be nil
//    let isbn: String? // don't know how to configure it, so for it will be nil
    let photo: String?

    var isTaken: Bool = false
    var returningDeadline: Date? = nil
}
