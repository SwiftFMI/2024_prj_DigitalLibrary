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
    @Published var selectedScope = 0
    @Published var areBooksFetched = false

    private var books: [Book] = []
    let booksProvider: BooksProvidable
    let userProvider: UserProvidable
    let authenticationProvider: AuthenticationProvidable

    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return booksForSelectedScope()
        } else {
            return booksForSelectedScope().filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    init(booksProvider: BooksProvidable, userProvider: UserProvidable, authenticationProvider: AuthenticationProvidable) {
        self.booksProvider = booksProvider
        self.userProvider = userProvider
        self.authenticationProvider = authenticationProvider
    }

    func getAllBooks() {
        guard !areBooksFetched else { return }

        isLoading = true

        Task {
            do {
                if let fetchedBooks = await booksProvider.getAll() {
                    books = fetchedBooks
                    DispatchQueue.main.async {
                        self.areBooksFetched = true
                    }
                } else {
                    books = []
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }

    private func booksForSelectedScope() -> [Book] {
        switch selectedScope {
        case 0: return books
        case 1: return groupBooks(by: \.author)
        case 2: return groupBooks(by: \.publisher)
        case 3: return groupBooks(by: \.year)
        default: return books
        }
    }
}

extension LibraryViewModel {
    private func groupBooks<T: Hashable>(by keyPath: KeyPath<Book, T>) -> [Book] {
        let groupedBooks = Dictionary(grouping: books, by: { $0[keyPath: keyPath] })
        if let selectedValue = books.first?[keyPath: keyPath] {
            return groupedBooks[selectedValue] ?? []
        } else {
            return []
        }
    }
}
