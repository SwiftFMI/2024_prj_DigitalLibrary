//
//  UserDataError.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

enum UserDataError: String, Error, Equatable {
    case empty = "Required field"
    case invalidEmail = "Email is invalid"
    case tooShortPassword = "Password is too short"
    case tooLongPassword = "Password is too long"
    case passwordIsMissingDigit = "Password must have a digit"
    case passwordIsMissingLowercase = "Password must have lowercase symbol"
    case passwordIsMissingUppercase = "Password must have uppercase symbol"
    case passwordIsMissingSpecialCharacter = "Password must have spacial character"
    case passwordsDoNotMatch = "Passwords do not match"
    case invalidName = "Name is invalid"
    case invalidPhoneNumber = "Phone number is invalid"
}
