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
    @Published var isScanning: Bool = false
    @Published var scannedText: String = ""

    private var books: [Book] = []
    let booksProvider: BooksProvidable
    let imagesProvider: ImagesProvidable
    let userProvider: UserProvidable
    let authenticationProvider: AuthenticationProvidable

    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            switch selectedScope {
            case 0: return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            case 1: return books.filter { $0.author.localizedCaseInsensitiveContains(searchText) }
            case 2: return books.filter { $0.publisher.localizedCaseInsensitiveContains(searchText) }
            case 3: return books.filter { String($0.year).localizedCaseInsensitiveContains(searchText) }
            default: return books
            }
        }
    }

    init(booksProvider: BooksProvidable,
         userProvider: UserProvidable,
         authenticationProvider: AuthenticationProvidable,
         imagesProvider: ImagesProvidable) {
        self.booksProvider = booksProvider
        self.userProvider = userProvider
        self.authenticationProvider = authenticationProvider
        self.imagesProvider = imagesProvider
    }

    func getAllBooks() {
        guard !areBooksFetched else { return }

        isLoading = true

        Task {
            books = await booksProvider.getAll()?
                .asyncMap { book in
                    let photo = try? await imagesProvider.downloadImage("\(book.title).jpg")

                    return Book(id: book.id,
                                title: book.title,
                                description: book.description,
                                author: book.author,
                                publisher: book.publisher,
                                year: book.year,
                                photo: photo,
                                isTaken: book.isTaken)
                } ?? []

            DispatchQueue.main.async {
                self.areBooksFetched = true
                self.isLoading = false
            }
        }
    }
}
