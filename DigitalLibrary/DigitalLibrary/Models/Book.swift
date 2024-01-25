//
//  Book.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct Book {
    let title: String
    let description: String
    let author: String
    let publisher: String
    let year: Int
    let qrcode: String? = nil // don't know how to configure it, so for it will be nil
    let isbn: String? = nil // don't know how to configure it, so for it will be nil
    let photo: String? = nil // don't know how to configure it, so for it will be nil

    var isTaken: Bool = false
    var returningDeadline: Date? = nil
}
