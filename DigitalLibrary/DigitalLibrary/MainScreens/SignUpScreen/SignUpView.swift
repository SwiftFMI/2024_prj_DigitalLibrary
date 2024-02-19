//
//  SignUpView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @FocusState var focusedField: Field?

    var body: some View {
        VStack(spacing: 10) {
            Text("Sign Up")
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
                    .focused($focusedField, equals: Field.firstName)
                    .submitLabel(.next)

                    TextInputView(title: "Last name",
                                  placeholder: "Enter last name",
                                  isValid: $viewModel.lastNameIsValid,
                                  text: $viewModel.lastName,
                                  fieldValidator: viewModel.validateLastName)
                    .focused($focusedField, equals: Field.lastName)
                    .submitLabel(.next)

                    TextInputView(title: "Phone number",
                                  placeholder: "Enter phone number",
                                  isValid: $viewModel.phoneNumberIsValid,
                                  text: $viewModel.phoneNumber,
                                  fieldValidator: viewModel.validatePhoneNumber)
                    .focused($focusedField, equals: Field.phoneNumber)
                    .submitLabel(.next)

                    TextInputView(title: "Email",
                                  placeholder: "Enter email",
                                  isValid: $viewModel.emailIsValid,
                                  text: $viewModel.email,
                                  fieldValidator: viewModel.validateEmail)
                    .focused($focusedField, equals: Field.email)
                    .submitLabel(.next)

                    TextInputView(title: "Password",
                                  placeholder: "Enter password",
                                  isSecure: true,
                                  isValid: $viewModel.passwordIsValid,
                                  text: $viewModel.password,
                                  fieldValidator: viewModel.validatePassword)
                    .focused($focusedField, equals: Field.password)
                    .submitLabel(.next)

                    TextInputView(title: "Confirm password",
                                  placeholder: "Enter password again",
                                  isSecure: true,
                                  isValid: $viewModel.confirmPasswordIsValid,
                                  text: $viewModel.confirmPassword,
                                  fieldValidator: viewModel.validateConfirmPassword)
                    .focused($focusedField, equals: Field.confirmPassword)
                    .submitLabel(.done)

                    Button("Sign Up") {
                        viewModel.signUp()
                    }
                    .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .padding()
                    .frame(width: 310, height: 50)
                    .background(viewModel.formIsValid ? .purple.opacity(0.9) : .purple.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .disabled(!viewModel.formIsValid)
                }
                .onSubmit {
                    switch focusedField {
                    case .firstName:
                        focusedField = .lastName
                    case .lastName:
                        focusedField = .phoneNumber
                    case .phoneNumber:
                        focusedField = .email
                    case .email:
                        focusedField = .password
                    case .password:
                        focusedField = .confirmPassword
                    default:
                        break
                    }
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
