//
//  SwiftUIChangeRootViewApp.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import SwiftUI

@main
struct SwiftUIChangeRootViewApp: App {
    @StateObject private var appRootManager = AppRootManager()
    private let authenticationProvider: AuthenticationProvidable = AuthenticationRepository()
    private let userProvider: UserProvidable = UserRepository()
    private let booksProvider: BooksProvidable = BooksRepository()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .login:
                    RootView(appRootManager: appRootManager,
                             authenticationProvider: authenticationProvider,
                             userProvider: userProvider)
                case .main:
                    MainTabbedView(authenticationProvider: authenticationProvider,
                                   userProvider: userProvider,
                                   booksProvider: booksProvider)
                }
            }
        }
    }
}
