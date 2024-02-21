//
//  MyBooksViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 19.02.24.
//

import SwiftUI

final class MyBooksViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var readingBooks: [String: Book] = [:]
    @Published var readBooks: [String: Book] = [:]
    @Published var isShowingDeleteAlert = false
    @Published var bookToDelete: Book?

    private let booksProvider: BooksProvidable
    private let userProvider: UserProvidable

    var firstSectionHeader: String {
        readingBooks.isEmpty ? "No current books" : "Books"
    }

    var secondSectionHeader: String {
        readBooks.isEmpty ? "" : "History"
    }

    init(booksProvider: BooksProvidable,
         userProvider: UserProvidable) {
        self.booksProvider = booksProvider
        self.userProvider = userProvider
    }

    func getAllBooks() {
        isLoading = true

        Task {
            guard let user = await userProvider.getCurrentUser() else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            DispatchQueue.main.async {
                self.readingBooks = user.readingBooks ?? [:]
                self.readBooks = user.readBooks ?? [:]
                self.isLoading = false
            }
        }
    }

    func moveBookToHistory(_ book: Book) {
        userProvider.removeBookFromReading(book)
        userProvider.addBookInRead(book)

        var updatedBook = book
        updatedBook.isTaken = false
        booksProvider.update(updatedBook, originalID: updatedBook.id)

        getAllBooks()
    }

    func removeBookFromHistory(_ book: Book) {
        userProvider.removeBookFromRead(book)
    }
}
