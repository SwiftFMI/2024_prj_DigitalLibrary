//
//  LibraryViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 17.02.24.
//


import SwiftUI

final class LibraryViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var isLoading = false

    private var books: [Book] = []
    private let booksProvider: BooksProvidable

    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    init(booksProvider: BooksProvidable) {
        self.booksProvider = booksProvider
    }

    func getAllBooks() {
        isLoading = true

        Task {
            do {
                if let fetchedBooks = await booksProvider.getAll() {
                    books = fetchedBooks
                } else {
                    books = []
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
