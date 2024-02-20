//
//  ProfileView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(50)

                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)

            ProfileInfoField(viewModel: .init(label: "Email",
                                              text: $viewModel.email,
                                              fieldType: .email,
                                              editingField: $viewModel.editingField,
                                              onCommit: { viewModel.updateUserData(field: .email) }))
            ProfileInfoField(viewModel: .init(label: "First name",
                                              text: $viewModel.firstName,
                                              fieldType: .firstName,
                                              editingField: $viewModel.editingField,
                                              onCommit: { viewModel.updateUserData(field: .firstName) }))
            ProfileInfoField(viewModel: .init(label: "Last name",
                                              text: $viewModel.lastName,
                                              fieldType: .lastName,
                                              editingField: $viewModel.editingField,
                                              onCommit: { viewModel.updateUserData(field: .lastName) }))
            ProfileInfoField(viewModel: .init(label: "Phone",
                                              text: $viewModel.phone,
                                              fieldType: .phone,
                                              editingField: $viewModel.editingField,
                                              onCommit: { viewModel.updateUserData(field: .phone) }))
        }
        .padding()
        .onAppear {
            viewModel.fetchCurrentUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(//appRootManager: AppRootManager(),
            authenticationProvider: AuthenticationRepositoryMock(),
            usersProvider: UserRepositoryMock()))
    }
}
