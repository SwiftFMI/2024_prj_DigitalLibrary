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
    let imagesProvider: ImagesProvidable

    @Published var user: UserModel?
    @Published var editingField: ProfileField? = nil
    @Published var showingAlert = false
    @Published var alertMessage = ""

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""

    @Published var isLoading = false

    @Published var imageState: ProfileModel.ImageState = .empty {
        didSet {
            switch imageState {
            case .success(_, let data):
                if let id = authenticationProvider.getCurrentUserID() {
                    imagesProvider.uploadProfileImage(id: id, data)
                }
            default:
                break
            }
        }
    }

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         usersProvider: UserProvidable,
         imagesProvider: ImagesProvidable) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.usersProvider = usersProvider
        self.imagesProvider = imagesProvider
        
    }

    @MainActor
    func fetchCurrentUser() {
        Task {
            isLoading = true

            guard let fetchedUser = await usersProvider.getCurrentUser() else {
                self.showingAlert = true
                self.alertMessage = "No user data was fetched."
                self.isLoading = false
                return
            }

            self.isLoading = false
            self.user = fetchedUser
            self.firstName = fetchedUser.firstName
            self.lastName = fetchedUser.lastName
            self.phone = fetchedUser.phone

            if let id = authenticationProvider.getCurrentUserID(),
               let data = try? await imagesProvider.downloadProfileImage(id: id),
               let uiImage = UIImage(data: data) {
                imageState = .success(Image(uiImage: uiImage), data)
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
                    UserDefaults.standard.removeObject(forKey: "remember-me")
                    isLoading = false
                } catch {
                    DispatchQueue.main.async {
                        self.showingAlert = true
                        self.alertMessage = "Failed to sign out: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                }
            }
        }
}
