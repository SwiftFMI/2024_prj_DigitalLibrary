//
//  EmptyValidator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

protocol Validatable {
    func validate(_ value: String?) throws -> String
}

class EmptyValidator: Validatable {
    func validate(_ input: String?) throws -> String {
        guard let input,
              !input.isEmpty else {
            throw UserDataError.empty
        }
        return input
    }
}
