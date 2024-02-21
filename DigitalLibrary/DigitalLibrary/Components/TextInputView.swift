//
//  TextInputView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 3.02.24.
//

import SwiftUI

struct TextInputView: View {
    private let title: String
    private let placeholder: String
    private let imageName: String
    private let fieldValidator: () -> String
    private let isPasswordField: Bool

    @Binding private var isValid: Bool
    @Binding private var text: String
    @State private var isSecure: Bool

    init(title: String,
         placeholder: String,
         imageName: String = "",
         isSecure: Bool = false,
         isValid: Binding<Bool>,
         text: Binding<String>,
         fieldValidator: @escaping () -> (String)) {
        self.title = title
        self.placeholder = placeholder
        self.imageName = imageName
        self.isSecure = isSecure
        self._isValid = isValid
        self._text = text
        self.fieldValidator = fieldValidator
        isPasswordField = isSecure
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(title)
            HStack(spacing: 15) {
                if imageName != "" {
                    Image(systemName: imageName)
                        .foregroundColor(.gray)
                }
                Group {
                    if !isSecure {
                        TextField(placeholder, text: $text)
                            .disableAutocorrection(true)

                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                .foregroundColor(text == "" ? .gray : .black)
                .onChange(of: text) { _ in
                    isValid = fieldValidator() == ""
                }

                if isPasswordField {
                    Button(action: {
                        isSecure.toggle()
                    }, label: {
                        Image(systemName: !isSecure ? "eye.slash" : "eye" )
                    })
                    .foregroundColor(.gray)
                }
            }
            Rectangle()
                .fill(isValid ? .gray : .red)
                .frame(height: 1)
            Text(fieldValidator())
                .foregroundColor(.red)
                .opacity(isValid ? 0 : 1)
        }
        .padding([.leading, .trailing], 40)
    }
}

struct TextInputView_Previews: PreviewProvider {
    @State private static var firstNameIsValid = true
    @State private static var firstName = ""

    @State private static var passwordIsValid = true
    @State private static var password = ""

    static var previews: some View {
        VStack {
            TextInputView(title: "First name",
                          placeholder: "Enter first name",
                          isValid: $firstNameIsValid,
                          text: $firstName,
                          fieldValidator: { "" })
            TextInputView(title: "Password",
                          placeholder: "Enter password",
                          isSecure: true,
                          isValid: $passwordIsValid,
                          text: $password,
                          fieldValidator: { "" })
        }
    }
}
