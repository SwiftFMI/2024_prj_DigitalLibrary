//
//  SignUpViewModel.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    @ObservedObject private var appRootManager: AppRootManager

    private let authenticationProvider: AuthenticationProvidable
    private let usersProvider: UserProvidable

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         usersProvider: UserProvidable) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.usersProvider = usersProvider
    }

    private var startedEditingFirstName = false
    private var startedEditingLastName = false
    private var startedEditingPhoneNumber = false
    private var startedEditingEmail = false
    private var startedEditingPassword = false
    private var startedEditingConfirmPassword = false

    @Published var firstNameIsValid = true {
        didSet {
            if firstNameIsValid == true {
                startedEditingFirstName = true
            }
        }
    }

    @Published var lastNameIsValid = true {
        didSet {
            if lastNameIsValid == true {
                startedEditingLastName = true
            }
        }
    }

    @Published var phoneNumberIsValid = true {
        didSet {
            if phoneNumberIsValid == true {
                startedEditingPhoneNumber = true
            }
        }
    }

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

    @Published var confirmPasswordIsValid = true {
        didSet {
            if confirmPasswordIsValid == true {
                startedEditingConfirmPassword = true
            }
        }
    }

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    var formIsValid: Bool {
         firstNameIsValid && lastNameIsValid && phoneNumberIsValid &&
         emailIsValid && passwordIsValid && confirmPasswordIsValid &&
         startedEditingFirstName && startedEditingLastName && startedEditingPhoneNumber &&
         startedEditingEmail && startedEditingPassword && startedEditingConfirmPassword
    }

    func validateFirstName() -> String {
        Validator.validate(firstName, type: .name)
    }

    func validateLastName() -> String {
        Validator.validate(lastName, type: .name)
    }

    func validatePhoneNumber() -> String {
        Validator.validate(phoneNumber, type: .phone)
    }

    func validateEmail() -> String {
        Validator.validate(email, type: .email)
    }

    func validatePassword() -> String {
        Validator.validate(password, type: .password)
    }

    func validateConfirmPassword() -> String {
        Validator.validate(confirmPassword, confirmPassword: password, type: .confirmPassword)
    }

    func signUp() {
        Task {
            do {
                try await authenticationProvider.signUp(emailAddress: email, password: password)

                guard let id = authenticationProvider.getCurrentUserID() else { return }

                usersProvider.createUser(UserModel(id: id,
                                                   firstName: firstName,
                                                   lastName: lastName,
                                                   email: email,
                                                   phone: phoneNumber))

                appRootManager.currentRoot = .main
            } catch {
                print(error)
            }
        }
    }
}
