//
//  PhoneNumberValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

final class PhoneNumberValidator: EmptyValidator {
    override func validate(_ input: String?) throws -> String {
        let notEmptyName = try super.validate(input)

        if !isName(notEmptyName) {
            throw UserDataError.invalidPhoneNumber
        }
        return notEmptyName
    }

    private func isName(_ phoneNumber: String) -> Bool {
        let phoneRegEx = "^\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: phoneNumber)
    }
}
