//
//  UserRepositoryMock.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 11.02.24.
//

final class UserRepositoryMock: UserProvidable {
    var currentUser: UserModel?

    func setUserID(_ id: String) {
        // No implementation
    }

    func createUser(_ user: UserModel) {
        currentUser = user
    }

    func getCurrentUser() async -> UserModel? {
        return currentUser
    }

    func updateUser(_ user: UserModel) {
        currentUser = user
    }

    func addBookInReading(_ book: Book) {
        currentUser?.readingBooks?.append(book)
    }

    func addBookInDropped(_ book: Book) {
        currentUser?.droppedBooks?.append(book)
    }

    func addBookInRead(_ book: Book) {
        currentUser?.readBooks?.append(book)
    }

    func removeBookFromReading(_ book: Book) {
        let readingBooks = currentUser?.readingBooks?.filter { $0 != book }
        currentUser?.readingBooks = readingBooks
    }

    func removeBookFromDropped(_ book: Book) {
        let droppedBooks = currentUser?.droppedBooks?.filter { $0 != book }
        currentUser?.droppedBooks = droppedBooks
    }

    func removeBookFromRead(_ book: Book) {
        let readBooks = currentUser?.readBooks?.filter { $0 != book}
        currentUser?.readBooks = readBooks
    }
}
