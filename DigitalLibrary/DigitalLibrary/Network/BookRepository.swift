//
//  BooksRepository.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 25.01.24.
//

import SwiftUI
import FirebaseDatabase

protocol BooksProvidable {
    func create(_ book: Book)
    func getAll() async -> [Book]?
    func get(_ id: String) async -> Book?
    func update(_ book: Book)
    func delete(_ id: String)
}

final class BooksRepository: BooksProvidable  {
    private lazy var reference: DatabaseReference? = {
        let ref = Database.database(url: "https://digitallibrary-e3242-default-rtdb.europe-west1.firebasedatabase.app")
            .reference()
            .child("books")
        return ref
    }()

    init() {
        FirebaseConfiguration.configure()
    }

    func create(_ book: Book) {
        reference?.childByAutoId().setValue(book.toDictionary())
    }

    func getAll() async -> [Book]? {
        await withCheckedContinuation { continuation in
            getAll { books in
                continuation.resume(returning: books)
            }
        }
    }

    private func getAll(completion: @escaping (([Book]?) -> Void)) {
        reference?.observeSingleEvent(of: .value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                completion(nil)
                return
            }

            let objects = children.compactMap { snapshot in
                return try? snapshot.data(as: Book.self)
            }

            completion(objects)
        }
    }

    func get(_ id: String) async -> Book? {
        await withCheckedContinuation { continuation in
            get(id: id) { book in
                continuation.resume(returning: book)
            }
        }
    }

    private func get(id: String, completion: @escaping ((Book?) -> Void)) {
        reference?.child(id).observeSingleEvent(of: .value) { snapshot in
            let object = try? snapshot.data(as: Book.self)
            completion(object)
        }
    }

    func update(_ book: Book) {
        reference?.childByAutoId().setValue(book.toDictionary())
    }

    func delete(_ id: String) {
        reference?.child(id).removeValue()
    }
}