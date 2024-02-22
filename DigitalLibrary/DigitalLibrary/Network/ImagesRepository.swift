//
//  BookCoversRepository.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 17.02.24.
//

import FirebaseStorage
import Foundation

protocol ImagesProvidable {
    func downloadBookCoverImage(_ title: String) async throws -> Data
    func downloadProfileImage(id: String) async throws -> Data
    func uploadProfileImage(id: String, _: Data)
}

final class ImagesRepository: ImagesProvidable {
    private var cachedImages: [String: Data?] = [:]
    private var profilePicture: Data?

    private lazy var reference = {
        let ref = Storage
            .storage()
            .reference()
        return ref
    }()

    init() {
        FirebaseConfiguration.configure()
    }

    func downloadBookCoverImage(_ title: String) async throws -> Data {
        if let image = cachedImages[title] {
            return image!
        }

        let result = await withCheckedContinuation { continuation in
            downloadBookCoverImage(title) { user in
                continuation.resume(returning: user)
            }
        }

        let image = try result.get()
        cachedImages[title] = image

        return image
    }

    private func downloadBookCoverImage(_ title: String, completion: @escaping (Result<Data, Error>) -> Void) {
        // 10 MB max size
        let maxSize: Int64 = 10 * 1024 * 1024

        reference.child("book-covers").child(title).getData(maxSize: maxSize) { result in
            completion(result)
        }
    }

    func downloadProfileImage(id: String) async throws -> Data {
        if let profilePicture {
            return profilePicture
        }

        let result = await withCheckedContinuation { continuation in
            downloadProfileImage(id: id) { image in
                continuation.resume(returning: image)
            }
        }

        let profilePicture = try result.get()
        self.profilePicture = profilePicture

        return profilePicture
    }

    private func downloadProfileImage(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        // 10 MB max size
        let maxSize: Int64 = 10 * 1024 * 1024

        reference
            .child("profile-pictures")
            .child(id)
            .getData(maxSize: maxSize) { result in
            completion(result)
        }
    }

    func uploadProfileImage(id: String, _ data: Data) {
        reference
            .child("profile-pictures")
            .child(id)
            .putData(data)
        profilePicture = data
    }
}
