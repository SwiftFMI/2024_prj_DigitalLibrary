//
//  ProfileViewModel.swift
//  DigitalLibrary
//
//  Created by Ognyan Yonchev on 16.02.24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @ObservedObject private var appRootManager: AppRootManager
    let authenticationProvider: AuthenticationProvidable
    let usersProvider: UserProvidable

    @Published var user: UserModel?
    @Published var editingField: ProfileField? = nil
    @Published var showingAlert = false
    @Published var alertMessage = ""

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""

    @Published var isLoading = false

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         usersProvider: UserProvidable) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.usersProvider = usersProvider
    }

    @MainActor
    func fetchCurrentUser() {
        Task {
            do {
                guard let fetchedUser = await usersProvider.getCurrentUser() else {
                        self.showingAlert = true
                        self.alertMessage = "No user data was fetched."
                    return
                }

                self.user = fetchedUser
                self.firstName = fetchedUser.firstName
                self.lastName = fetchedUser.lastName
                self.phone = fetchedUser.phone
            }
        }
    }

    func updateUserData(field: ProfileField) {
        guard var updatedUser = user else {
            self.showingAlert = true
            self.alertMessage = "Failed to update user data"
            return
        }

        switch field {
        case .firstName:
            updatedUser.firstName = self.firstName
        case .lastName:
            updatedUser.lastName = self.lastName
        case .phone:
            updatedUser.phone = self.phone
        }

        usersProvider.updateUser(updatedUser)
    }

    func signOut() {
        isLoading = true

            Task {
                do {
                    try authenticationProvider.signOut()
                    appRootManager.currentRoot = .login
                } catch {
                    DispatchQueue.main.async {
                        self.showingAlert = true
                        self.alertMessage = "Failed to sign out: \(error.localizedDescription)"
                    }
                }
            }
        }
}
