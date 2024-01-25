//
//  TestViewModel.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 25.01.24.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift

protocol Repository {
    associatedtype T

    func create(_: T)
    func read(id: String) async throws -> T?
}

final class BookRepository: Repository  {
    typealias T = Book

    let reference: DatabaseReference

    init() {
        FirebaseApp.configure()
        reference = Database.database(url: "https://digitallibrary-e3242-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }

    func create(_ book: Book) {
        reference.child("books/\(String(describing: book.isbn))/title").setValue(book.title)
        reference.child("books/\(String(describing: book.isbn))/description").setValue(book.description)
        reference.child("books/\(String(describing: book.isbn))/author").setValue(book.author)
        reference.child("books/\(String(describing: book.isbn))/publisher").setValue(book.publisher)
        reference.child("books/\(String(describing: book.isbn))/year").setValue(book.year)
        reference.child("books/\(String(describing: book.isbn))/isbn").setValue(book.isbn)
        reference.child("books/\(String(describing: book.isbn))/photo").setValue(book.photo)
        reference.child("books/\(String(describing: book.isbn))/isTaken").setValue(book.isTaken)
        reference.child("books/\(String(describing: book.isbn))/returningDeadline").setValue(book.returningDeadline)
    }

    func read(id: String) async throws -> Book? {
        guard let title = try await reference.child("books/\(id)/title").getData().value as? String,
              let description = try await reference.child("books/\(id)/description").getData().value as? String,
              let author = try await reference.child("books/\(id)/author").getData().value as? String,
              let publisher = try await reference.child("books/\(id)/publisher").getData().value as? String,
              let year = try await reference.child("books/\(id)/year").getData().value as? Int,
              let isTaken = try await reference.child("books/\(id)/isTaken").getData().value as? Bool else {
            return nil
        }

        let returningDeadline = try await reference.child("books/\(id)/returningDeadline").getData().value as? Date

        return Book(title: title,
                    description: description,
                    author: author,
                    publisher: publisher,
                    year: year,
                    isTaken: isTaken,
                    returningDeadline: returningDeadline)
    }
}
