//
//  BookCoversRepository.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 17.02.24.
//

import FirebaseStorage
import Foundation

protocol ImagesProvidable {
    func downloadImage(_ title: String) async throws -> Data
}

final class BookCoversRepository: ImagesProvidable {
    private lazy var reference = {
        let ref = Storage
            .storage()
            .reference()
            .child("book-covers")
        return ref
    }()

    init() {
        FirebaseConfiguration.configure()
    }

    func downloadImage(_ title: String) async throws -> Data {
        let result = await withCheckedContinuation { continuation in
            downloadImage(title) { user in
                continuation.resume(returning: user)
            }
        }

        return try result.get()
    }

    private func downloadImage(_ title: String, completion: @escaping (Result<Data, Error>) -> Void) {
        // 10 MB max size
        let maxSize: Int64 = 10 * 1024 * 1024

        reference.child(title).getData(maxSize: maxSize) { result in
            completion(result)
        }
    }
}
