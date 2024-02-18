//
//  MainTabbedViewModel.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 18.02.24.
//

import SwiftUI

final class MainTabbedViewModel: ObservableObject {
    @Published var selectedTab = 0

    let authenticationProvider: AuthenticationProvidable
    let userProvider: UserProvidable
    let booksProvider: BooksProvidable

    init(authenticationProvider: AuthenticationProvidable,
         userProvider: UserProvidable,
         booksProvider: BooksProvidable,
         selectedTab: Int = 0) {
        self.authenticationProvider = authenticationProvider
        self.userProvider = userProvider
        self.booksProvider = booksProvider
        self.selectedTab = selectedTab

        guard let id = authenticationProvider.getCurrentUserID() else { return }
        userProvider.setUserID(id)
    }
}
