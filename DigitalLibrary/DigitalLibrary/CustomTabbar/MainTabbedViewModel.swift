//
//  MainTabbedViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 18.02.24.
//

import SwiftUI

final class MainTabbedViewModel: ObservableObject {
    @Published var selectedTab = 0
    @ObservedObject var appRootManager: AppRootManager

    let authenticationProvider: AuthenticationProvidable
    let userProvider: UserProvidable
    let booksProvider: BooksProvidable
    let imagesProvider: ImagesProvidable

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         userProvider: UserProvidable,
         booksProvider: BooksProvidable,
         imagesProvider: ImagesProvidable,
         selectedTab: Int = 0) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.userProvider = userProvider
        self.booksProvider = booksProvider
        self.imagesProvider = imagesProvider
        self.selectedTab = selectedTab

        guard let id = authenticationProvider.getCurrentUserID() else { return }
        userProvider.setUserID(id)
    }
}
