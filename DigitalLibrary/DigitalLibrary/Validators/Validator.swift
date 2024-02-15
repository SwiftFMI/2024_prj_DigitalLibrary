//
//  Validator.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

final class Validator {
    static func validate(_ text: String?, confirmPassword: String? = nil, type: ValidatableFields) -> String {
        switch type {
        case .none:
            return ""
        case .required:
            return validate(text, validator: EmptyValidator())
        case .name:
            return validate(text, validator: NameValidator())
        case .email:
            return validate(text, validator: EmailValidator())
        case .password:
            return validate(text, validator: PasswordValidator())
        case .phone:
            return validate(text, validator: PhoneNumberValidator())
        case .confirmPassword:
            return validateConfirmPassword(text, confirmPassword: confirmPassword)
        }
    }

    private static func validate(_ text: String?, validator: Validatable) -> String {
        do {
            try _ = validator.validate(text)

            return ""
        } catch let error as UserDataError {
            return error.rawValue
        } catch {
            return "Unknown validation error"
        }
    }

    private static func validateConfirmPassword(_ text: String?, confirmPassword: String?) -> String {
        do {
            let _ = try ConfirmPasswordValidator().passwordsAreTheSame(password1: text, password2: confirmPassword)

            return ""
        } catch let error as UserDataError {
            return error.rawValue
        } catch {
            return "Unknown validation error"
        }
    }

    enum ValidatableFields {
        case none
        case required
        case name
        case phone
        case email
        case password
        case confirmPassword
    }
}
