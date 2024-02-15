//
//  Book.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct Book: Codable, Hashable {
    let title: String
    let description: String
    let author: String
    let publisher: String
    let year: Int
//    let qrcode: String? // don't know how to configure it, so for it will be nil
//    let isbn: String? // don't know how to configure it, so for it will be nil
    let photo: String?

    var isTaken: Bool = false
    var returningDeadline: Date? = nil
}
