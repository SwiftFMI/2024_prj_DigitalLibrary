//
//  AuthenticationRepository.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 28.01.24.
//

import SwiftUI
import FirebaseAuth

protocol AuthenticationProvidable {
    func getCurrentUserID() -> String?
    func signUp(emailAddress: String, password: String) async throws
    func signIn(emailAddress: String, password: String) async throws
    func signOut() throws
}

final class AuthenticationRepository: AuthenticationProvidable {
    init() {
        FirebaseConfiguration.configure()
    }

    func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }

    func signUp(emailAddress: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: emailAddress, password: password)
    }

    func signIn(emailAddress: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: emailAddress, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
