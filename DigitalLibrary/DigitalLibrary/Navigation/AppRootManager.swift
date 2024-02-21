//
//  AppRootManager.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

final class AppRootManager: ObservableObject {
    @Published var currentRoot: RootScreens = {
        let isUserRemembered = UserDefaults.standard.value(forKey: "remember-me") as? Bool ?? false

        return isUserRemembered ? .main : .login
    }()

    enum RootScreens {
        case login
        case main
    }
}
