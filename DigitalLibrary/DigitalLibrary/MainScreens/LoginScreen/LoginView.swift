//
//  LoginView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 3.02.24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack() {
            Spacer()
            VStack(spacing: 10) {
                Text("Login")
                    .padding()
                    .font(.largeTitle)
                    .bold()

                TextInputView(title: "Email",
                              placeholder: "Enter email",
                              imageName: "person",
                              isValid: $viewModel.emailIsValid,
                              text: $viewModel.email,
                              fieldValidator: viewModel.validateEmail)
                TextInputView(title: "Password",
                              placeholder: "Enter password",
                              imageName: "lock",
                              isSecure: true,
                              isValid: $viewModel.passwordIsValid,
                              text: $viewModel.password,
                              fieldValidator: viewModel.validatePassword)

                Button("Sign In") {
                    viewModel.signIn()
                }
                .padding()
                .frame(width: 275, height: 50)
                .background(viewModel.formIsValid ? .purple.opacity(0.9) : .purple.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(30)
                .disabled(!viewModel.formIsValid)

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.8))
                    NavigationLink("Sign Up", 
                                   destination: SignUpView(viewModel: SignUpViewModel(
                                    appRootManager: viewModel.appRootManager,
                                    authenticationProvider: viewModel.authenticationProvider,
                                    usersProvider: viewModel.userProvider
                                   ))
                    )
                        .foregroundColor(.blue)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .padding()
            }
            .padding()
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(
            appRootManager: AppRootManager(),
            authenticationProvider: AuthenticationRepositoryMock(),
            userProvider: UserRepositoryMock()
        ))
    }
}
