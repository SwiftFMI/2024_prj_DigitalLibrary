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
        currentUser?.readingBooks?[book.title] = book
        if let currentUser {
            updateUser(currentUser)
        }
    }

    func addBookInUnfinished(_ book: Book) {
        currentUser?.unfinishedBooks?[book.title] = book
        if let currentUser {
            updateUser(currentUser)
        }
    }

    func addBookInRead(_ book: Book) {
        currentUser?.readBooks?[book.title] = book
        if let currentUser {
            updateUser(currentUser)
        }
    }

    func removeBookFromReading(_ book: Book) {
        currentUser?.readingBooks?.removeValue(forKey: book.title)
        if let currentUser {
            updateUser(currentUser)
        }
    }

    func removeBookFromUnfinished(_ book: Book) {
        currentUser?.unfinishedBooks?.removeValue(forKey: book.title)
        if let currentUser {
            updateUser(currentUser)
        }
    }

    func removeBookFromRead(_ book: Book) {
        currentUser?.readBooks?.removeValue(forKey: book.title)
        if let currentUser {
            updateUser(currentUser)
        }
    }
}
