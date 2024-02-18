//
//  BookDetailsViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 17.02.24.
//

import SwiftUI

final class BookDetailsViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var buttonTitle = ""
    @Published var buttonImage = ""

    private var book: Book
    private let booksProvider: BooksProvidable
    private let userProvider: UserProvidable
    private let authenticationProvider: AuthenticationProvidable

    var photo: Data? {
        book.photo
    }

    var title: String {
        book.title
    }

    var author: String {
        book.author
    }

    var publisher: String {
        book.publisher
    }

    var year: Int {
        book.year
    }

    var description: String {
        book.description
    }

    var isTaken: Bool {
        book.isTaken
    }

    init(book: Book,
         booksProvider: BooksProvidable,
         userProvider: UserProvidable,
         authenticationProvider: AuthenticationProvidable) {
        self.book = book
        self.booksProvider = booksProvider
        self.userProvider = userProvider
        self.authenticationProvider = authenticationProvider
        updateButtonState()
    }

    func addToMyBooks() {
        book.isTaken = true
        booksProvider.update(book, originalID: book.id)
        userProvider.addBookInReading(book)
        updateButtonState()
        sendLocalNotification()
    }

    private func updateButtonState() {
        if isTaken {
            buttonTitle = "Аlready taken"
            buttonImage = "star.fill"
        } else {
            buttonTitle = "Add to My Books"
            buttonImage = "star"
        }
    }

    private func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Added new book"
        content.body = "The \(title) has been successfully added to your library."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { [weak self] error in
            if let error = error {
                self?.showingAlert = true
                self?.alertMessage = error.localizedDescription
            }
        }
    }
}
