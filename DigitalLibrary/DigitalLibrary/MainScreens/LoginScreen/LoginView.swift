//
//  LoginView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 3.02.24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState var focusedField: Field?

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Login")
                    .padding()
                    .font(.largeTitle)
                    .bold()
                ScrollView {
                    VStack(spacing: 10) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            TextInputView(title: "Email",
                                          placeholder: "Enter email",
                                          imageName: "person",
                                          isValid: $viewModel.emailIsValid,
                                          text: $viewModel.email,
                                          fieldValidator: viewModel.validateEmail)
                                .focused($focusedField, equals: Field.email)
                                .submitLabel(.next)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)

                            TextInputView(title: "Password",
                                          placeholder: "Enter password",
                                          imageName: "lock",
                                          isSecure: true,
                                          isValid: $viewModel.passwordIsValid,
                                          text: $viewModel.password,
                                          fieldValidator: viewModel.validatePassword)
                                .focused($focusedField, equals: Field.password)
                                .submitLabel(.done)
                                .autocapitalization(.none)

                            Button("Sign In") {
                                viewModel.signIn()
                            }
                            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                                Button("OK", role: .cancel) { }
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
                        }
                    }
                    .onSubmit {
                        switch focusedField {
                        case .email:
                            focusedField = .password
                        default:
                            break
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(false)
            }
            .onTapGesture {
                hideKeyboard()
            }
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
