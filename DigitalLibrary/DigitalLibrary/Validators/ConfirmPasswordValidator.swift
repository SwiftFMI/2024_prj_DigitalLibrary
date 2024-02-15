//
//  ConfirmPasswordValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

final class ConfirmPasswordValidator: PasswordValidator {
    func passwordsAreTheSame(password1: String?, password2: String?) throws -> String {
        if password1 != password2 {
            throw UserDataError.passwordsDoNotMatch
        }

        return password1 ?? ""
    }
}
