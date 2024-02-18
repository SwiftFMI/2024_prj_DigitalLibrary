//
//  BooksRepositoryMock.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 11.02.24.
//

final class BooksRepositoryMock: BooksProvidable {
    private var books: [Book] = BooksMockData.books

    func create(_ book: Book) {
        books.append(book)
    }

    func getAll() async -> [Book]? {
        return books
    }

    func get(_ title: String) async -> Book? {
        return books.first(where: { $0.title == title })
    }

    func update(_ book: Book, originalID: String) {
        if let index = books.firstIndex(where: { $0.id == originalID }) {
            books[index] = book
        }
    }

    func delete(_ title: String) {
        books.removeAll { $0.title == title }
    }
}
