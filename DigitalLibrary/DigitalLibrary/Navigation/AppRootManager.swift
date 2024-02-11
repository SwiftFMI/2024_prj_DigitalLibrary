//
//  AppRootManager.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import Foundation

final class AppRootManager: ObservableObject {
    @Published var currentRoot: rootScreens = .login

    enum rootScreens {
        case login
        case main
    }
}
