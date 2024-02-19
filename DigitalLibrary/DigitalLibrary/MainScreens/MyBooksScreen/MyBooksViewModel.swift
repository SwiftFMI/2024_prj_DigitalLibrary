//
//  MyBooksViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 19.02.24.
//

import SwiftUI

final class MyBooksViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var readingBooks: [Book] = []
    @Published var unfinishedBooks: [Book] = []

    let booksProvider: BooksProvidable
    let imagesProvider: ImagesProvidable
    let userProvider: UserProvidable
    let authenticationProvider: AuthenticationProvidable

    init(booksProvider: BooksProvidable,
         userProvider: UserProvidable,
         imagesProvider: ImagesProvidable,
         authenticationProvider: AuthenticationProvidable) {
        self.booksProvider = booksProvider
        self.userProvider = userProvider
        self.imagesProvider = imagesProvider
        self.authenticationProvider = authenticationProvider
    }

    func getAllReadingBooks() {
        isLoading = true

        Task {
            guard let user = await userProvider.getCurrentUser() else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            self.readingBooks = user.readingBooks ?? []
            self.isLoading = false
        }
    }

    func getAllUnfinishedBooks() {
        isLoading = true

        Task {
            guard let user = await userProvider.getCurrentUser() else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            self.unfinishedBooks = user.unfinishedBooks ?? []
            self.isLoading = false
        }
    }
}
