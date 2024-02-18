//
//  LoginViewModel.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 4.02.24.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @ObservedObject private(set) var appRootManager: AppRootManager

    private(set) var authenticationProvider: AuthenticationProvidable
    private(set) var userProvider: UserProvidable

    private var startedEditingEmail = false
    private var startedEditingPassword = false

    @Published var emailIsValid = true {
        didSet {
            if emailIsValid == true {
                startedEditingEmail = true
            }
        }
    }

    @Published var passwordIsValid = true {
        didSet {
            if passwordIsValid == true {
                startedEditingPassword = true
            }
        }
    }

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""

    @Published var isLoading = false

    var formIsValid: Bool {
        emailIsValid && passwordIsValid && startedEditingEmail && startedEditingPassword
    }

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         userProvider: UserProvidable) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.userProvider = userProvider
    }

    func validateEmail() -> String {
        email != "" ? "" : "Required"
    }

    func validatePassword() -> String {
        password != "" ? "" : "Required"
    }

    func signIn() {
        isLoading = true
        Task {
            do {
                try await authenticationProvider.signIn(emailAddress: email, password: password)

                appRootManager.currentRoot = .main
            } catch  {
                showingAlert = true

                let error = error as NSError
                if error.code == 17004 {
                    alertMessage = "Invalid credentials"
                } else {
                    alertMessage = error.localizedDescription
                }
            }
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}
