//
//  UserRepository.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 7.02.24.
//

import FirebaseDatabase

protocol UserProvidable {
    func setUserID(_ id: String)
    func createUser(_ user: UserModel)
    func getCurrentUser() async -> UserModel?
    func updateUser(_ user: UserModel)
    func addBookInReading(_ book: Book)
    func addBookInDropped(_ book: Book)
    func addBookInRead(_ book: Book)
    func removeBookFromReading(_ book: Book)
    func removeBookFromDropped(_ book: Book)
    func removeBookFromRead(_ book: Book)
}

final class UserRepository: UserProvidable {
    private var userID: String?

    private lazy var reference: DatabaseReference? = {
        let path: String
        if let userID {
            path = "users/\(userID)"
        } else {
            path = "users"
        }

        let ref = Database.database(url: "https://digitallibrary-e3242-default-rtdb.europe-west1.firebasedatabase.app")
            .reference()
            .child(path)
        return ref
    }()

    init() {
        FirebaseConfiguration.configure()
    }
    
    func setUserID(_ id: String) {
        self.userID = id
    }

    func createUser(_ user: UserModel) {
        reference?.setValue(user.toDictionary())
    }

    func getCurrentUser() async -> UserModel? {
        await withCheckedContinuation { continuation in
            getCurrentUser() { user in
                continuation.resume(returning: user)
            }
        }
    }

    private func getCurrentUser(completion: @escaping ((UserModel?) -> Void)) {
        reference?.observeSingleEvent(of: .value) { snapshot in
            let object = try? snapshot.data(as: UserModel.self)
            completion(object)
        }
    }

    func updateUser(_ user: UserModel) {
        reference?.setValue(user.toDictionary())
    }

    func addBookInReading(_ book: Book) {
        reference?.child("readingBooks/\(book.title)").setValue(book.toDictionary())
    }

    func addBookInDropped(_ book: Book) {
        reference?.child("droppedBooks/\(book.title)").setValue(book.toDictionary())
    }

    func addBookInRead(_ book: Book) {
        reference?.child("readBooks/\(book.title)").setValue(book.toDictionary())
    }

    func removeBookFromReading(_ book: Book) {
        reference?.child("readingBooks/\(book.title)").removeValue()
    }

    func removeBookFromDropped(_ book: Book) {
        reference?.child("droppedBooks/\(book.title)").removeValue()
    }

    func removeBookFromRead(_ book: Book) {
        reference?.child("readBooks/\(book.title)").removeValue()
    }

}
