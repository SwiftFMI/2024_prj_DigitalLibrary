//
//  StatisticsViewModel.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import Foundation

enum ChartType {
    case forTime
    case forGenre
    case forAuthor
}

final class StatisticsViewModel: ObservableObject {
    @Published var readingBooks: [String: Book] = [:]
    @Published var readBooks: [String: Book] = [:]
    @Published var allBooks: [String: Book] = [:]
    @Published var isLoading = false
    @Published var areBooksFetched = false

    private let userProvider: UserProvidable

    init(userProvider: UserProvidable) {
        self.userProvider = userProvider
        getAllBooks()
    }

    func getAllBooks() {
        Task {
            isLoading = true

            guard let user = await userProvider.getCurrentUser() else {
                return
            }

            DispatchQueue.main.async {
                self.readingBooks = user.readingBooks ?? [:]
                self.readBooks = user.readBooks ?? [:]
                self.allBooks = self.readingBooks
                self.allBooks.merge(self.readBooks) { (_, new) in new }
                self.isLoading = false
            }
        }
    }
}
