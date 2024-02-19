//
//  NameValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

final class NameValidator: EmptyValidator {
    override func validate(_ input: String?) throws -> String {
        let notEmptyName = try super.validate(input)

        if !isName(notEmptyName) {
            throw UserDataError.invalidName
        }
        return notEmptyName
    }

    private func isName(_ name: String) -> Bool {
        let nameRegEx = "^[a-zA-Z-' ]{1,50}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePredicate.evaluate(with: name)
    }
}
