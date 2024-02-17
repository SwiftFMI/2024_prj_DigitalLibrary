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

    private var book: Book

    var buttonTitle: String {
        isTaken ? "Added to My Books" : "Add to My Books"
    }

    var buttonImage: String {
        isTaken ? "star.fill" : "star"
    }

    var photo: String {
        book.photo ?? "brave_new_world"
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

    init(book: Book) {
        self.book = book
    }

    func addToMyBooks() {
        book.isTaken = true
        sendLocalNotification()
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
