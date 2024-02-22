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
    func addBookInRead(_ book: Book)
    func removeBookFromReading(_ book: Book)
    func removeBookFromRead(_ book: Book)
}

final class UserRepository: UserProvidable {
    private var userID: String?
    private var user: UserModel?

    private lazy var reference: DatabaseReference? = {
        let ref = Database.database(url: "https://digitallibrary-e3242-default-rtdb.europe-west1.firebasedatabase.app")
            .reference()
            .child("users")
        return ref
    }()

    init() {
        FirebaseConfiguration.configure()
    }
    
    func setUserID(_ id: String) {
        self.userID = id
        reference = reference?.child(id)
        listenForUserChanges()
    }

    func createUser(_ user: UserModel) {
        reference?.child(user.id).setValue(user.toDictionary())
        self.user = user
    }

    func getCurrentUser() async -> UserModel? {
        if let user {
            return user
        }

        return await withCheckedContinuation { continuation in
            getCurrentUser() { user in
                continuation.resume(returning: user)
            }
        }
    }

    func listenForUserChanges() {
        reference?.observe(.value) { [weak self] snapshot in
            if let user = try? snapshot.data(as: UserModel.self) {
                self?.user = user
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
        self.user = user
        reference?.setValue(user.toDictionary())
    }

    func addBookInReading(_ book: Book) {
        user?.readingBooks?[book.title] = book
        reference?.child("readingBooks/\(book.title)").setValue(book.toDictionary())
    }

    func addBookInRead(_ book: Book) {
        user?.readBooks?[book.title] = book
        reference?.child("readBooks/\(book.title)").setValue(book.toDictionary())
    }

    func removeBookFromReading(_ book: Book) {
        user?.readingBooks?.removeValue(forKey: book.title)
        reference?.child("readingBooks/\(book.title)").removeValue()
    }

    func removeBookFromRead(_ book: Book) {
        user?.readBooks?.removeValue(forKey: book.title)
        reference?.child("readBooks/\(book.title)").removeValue()
    }
}
