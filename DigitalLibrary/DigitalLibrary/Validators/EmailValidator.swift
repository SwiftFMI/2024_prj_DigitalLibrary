//
//  EmailValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

final class EmailValidator: EmptyValidator {

    override func validate(_ input: String?) throws -> String {
        let notEmptyEmail = try super.validate(input)

        if !isEmail(notEmptyEmail) {
            throw UserDataError.invalidEmail
        }
        return notEmptyEmail
    }

    private func isEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]{1,64}@(?=.{1,255}$)[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
