//
//  BookCoversRepositoryMock.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 22.02.24.
//

import Foundation

final class ImagesRepositoryMock: ImagesProvidable {
    enum MockError: Error {
        case error
    }

    private var profilePictures: [String: Data] = [:]

    func downloadProfileImage(id: String) async throws -> Data {
        guard let picture = profilePictures[id] else {
            throw MockError.error
        }

        return picture
    }

    func uploadProfileImage(id: String, _ data: Data) {
        profilePictures[id] = data
    }

    func downloadBookCoverImage(_ title: String) async throws -> Data {
        guard let picture = profilePictures[title] else {
            throw MockError.error
        }

        return picture
    }
}
