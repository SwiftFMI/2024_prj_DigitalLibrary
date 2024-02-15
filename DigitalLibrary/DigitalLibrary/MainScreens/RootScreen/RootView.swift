//
//  RootView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 4.02.24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject private var appRootManager: AppRootManager
    private let authenticationProvider:  AuthenticationProvidable
    private let userProvider: UserProvidable

    init(appRootManager: AppRootManager,
         authenticationProvider: AuthenticationProvidable,
         userProvider: UserProvidable) {
        self.appRootManager = appRootManager
        self.authenticationProvider = authenticationProvider
        self.userProvider = userProvider
    }

    var body: some View {
        let viewModel = LoginViewModel(appRootManager: appRootManager,
                                       authenticationProvider: authenticationProvider, 
                                       userProvider: userProvider)

        LoginView(viewModel: viewModel)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(appRootManager: AppRootManager(),
                 authenticationProvider: AuthenticationRepositoryMock(), 
                 userProvider: UserRepositoryMock())
    }
}
