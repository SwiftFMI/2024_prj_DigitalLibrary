//
//  PasswordValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

class PasswordValidator: EmptyValidator {
    override func validate(_ input: String?) throws -> String {
        let notEmptyPassword = try super.validate(input)

        try ensureSize(notEmptyPassword)
        try ensureContainsDigits(notEmptyPassword)
        try ensureContainsLowerCase(notEmptyPassword)
        try ensureContainsUpperCase(notEmptyPassword)
        try ensureContainsSpecialCharacter(notEmptyPassword)

        return notEmptyPassword
    }

    private func ensureSize(_ password: String) throws {
        if password.count < 8 {
            throw UserDataError.tooShortPassword
        } else if password.count > 20 {
            throw UserDataError.tooLongPassword
        }
    }
    private func ensureContainsDigits(_ password: String) throws {
        let passwordRegEx = ".*[0-9]+.*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if !passwordPredicate.evaluate(with: password) {
            throw UserDataError.passwordIsMissingDigit
        }
    }

    private func ensureContainsSpecialCharacter(_ password: String) throws {
        let passwordRegEx = ".*[_!@#$%^&*()-]+.*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if !passwordPredicate.evaluate(with: password) {
            throw UserDataError.passwordIsMissingSpecialCharacter
        }
    }

    private func ensureContainsLowerCase(_ password: String) throws {
        let passwordRegEx = ".*[a-z]+.*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if !passwordPredicate.evaluate(with: password) {
            throw UserDataError.passwordIsMissingLowercase
        }
    }

    private func ensureContainsUpperCase(_ password: String) throws {
        let passwordRegEx = ".*[A-Z]+.*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if !passwordPredicate.evaluate(with: password) {
            throw UserDataError.passwordIsMissingUppercase
        }
    }
}
