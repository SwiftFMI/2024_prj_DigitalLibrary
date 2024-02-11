//
//  AuthenticationRepositoryMock.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 11.02.24.
//

import Foundation

final class AuthenticationRepositoryMock: AuthenticationProvidable {
    private var registeredUsers: [FirebaseUser] = []
    private var currentUser: FirebaseUser?

    func getCurrentUserID() -> String? {
        currentUser?.id
    }
    
    func signUp(emailAddress: String, password: String) async throws {
        registeredUsers.append(FirebaseUser(id: UUID().uuidString,
                                            email: emailAddress,
                                            password: password))
    }
    
    func signIn(emailAddress: String, password: String) async throws {
        currentUser = registeredUsers.first { $0.email == emailAddress && $0.password == password }
    }
    
    func signOut() throws {
        currentUser = nil
    }
}

private extension AuthenticationRepositoryMock {
    struct FirebaseUser {
        let id: String
        let email: String
        let password: String
    }
}
