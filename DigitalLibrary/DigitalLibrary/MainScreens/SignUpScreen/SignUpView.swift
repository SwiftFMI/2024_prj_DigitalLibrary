//
//  SignUpView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Registration")
                .padding()
                .font(.largeTitle)
                .bold()
            ScrollView {
                VStack(spacing: 10) {
                    TextInputView(title: "First name",
                                  placeholder: "Enter first name",
                                  isValid: $viewModel.firstNameIsValid,
                                  text: $viewModel.firstName,
                                  fieldValidator: viewModel.validateFirstName)
                    TextInputView(title: "Last name",
                                  placeholder: "Enter last name",
                                  isValid: $viewModel.lastNameIsValid,
                                  text: $viewModel.lastName,
                                  fieldValidator: viewModel.validateLastName)
                    TextInputView(title: "Phone number",
                                  placeholder: "Enter phone number",
                                  isValid: $viewModel.phoneNumberIsValid,
                                  text: $viewModel.phoneNumber,
                                  fieldValidator: viewModel.validatePhoneNumber)
                    TextInputView(title: "Email",
                                  placeholder: "Enter email",
                                  isValid: $viewModel.emailIsValid,
                                  text: $viewModel.email,
                                  fieldValidator: viewModel.validateEmail)
                    TextInputView(title: "Password",
                                  placeholder: "Enter password",
                                  isSecure: true,
                                  isValid: $viewModel.passwordIsValid,
                                  text: $viewModel.password,
                                  fieldValidator: viewModel.validatePassword)
                    TextInputView(title: "Confirm password",
                                  placeholder: "Enter password again",
                                  isSecure: true,
                                  isValid: $viewModel.confirmPasswordIsValid,
                                  text: $viewModel.confirmPassword,
                                  fieldValidator: viewModel.validateConfirmPassword)
                    Button("Sign Up") {
                        viewModel.signUp()
                    }

                    .padding()
                    .frame(width: 310, height: 50)
                    .background(viewModel.formIsValid ? .purple.opacity(0.9) : .purple.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .disabled(!viewModel.formIsValid)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(
            appRootManager: AppRootManager(),
            authenticationProvider: AuthenticationRepositoryMock(),
            usersProvider: UserRepositoryMock()
        ))
    }
}
