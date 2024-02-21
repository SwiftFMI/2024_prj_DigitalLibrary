//
//  ProfileInfoFieldView.swift
//  DigitalLibrary
//
//  Created by Ognyan Yonchev on 18.02.24.
//

import SwiftUI

enum ProfileField {
    case firstName, lastName, phone
}

struct ProfileInfoField: View {
    @ObservedObject var viewModel: ProfileInfoFieldViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.label)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            HStack {
                TextField(viewModel.label, text: $viewModel.text)
                    .disabled(!viewModel.isEditing)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .foregroundColor(viewModel.isEditing ? .primary : .gray)

                Spacer()

                Button(action: {
                    withAnimation {
                        if viewModel.isEditing {
                            viewModel.onCommit()
                        }
                        viewModel.editingField = viewModel.isEditing ? nil : viewModel.fieldType
                    }
                }) {
                    Image(systemName: viewModel.isEditing ? "checkmark.circle.fill" : "pencil.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(viewModel.isEditing ? .blue : .purple.opacity(0.6))
                        .padding(6)
                }
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 44, height: 44)
            }
        }
        .padding(.vertical, 5)
    }
}
