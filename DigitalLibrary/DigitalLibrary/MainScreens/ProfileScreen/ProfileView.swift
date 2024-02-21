//
//  ProfileView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack {

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(50)
                            .foregroundColor(.purple.opacity(colorScheme == .dark ? 1 : 0.6))

                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.purple.opacity(colorScheme == .dark ? 1 : 0.6))
                    }
                    .frame(maxWidth: .infinity)

                    ProfileInfoField(viewModel: .init(label: "First name",
                                                      text: $viewModel.firstName,
                                                      fieldType: .firstName,
                                                      editingField: $viewModel.editingField,
                                                      onCommit: { viewModel.updateUserData(field: .firstName) }))
                    .submitLabel(.done)
                    .keyboardType(.namePhonePad)
                    .autocapitalization(.none)

                    ProfileInfoField(viewModel: .init(label: "Last name",
                                                      text: $viewModel.lastName,
                                                      fieldType: .lastName,
                                                      editingField: $viewModel.editingField,
                                                      onCommit: { viewModel.updateUserData(field: .lastName) }))
                    .submitLabel(.done)
                    .keyboardType(.namePhonePad)
                    .autocapitalization(.none)

                    ProfileInfoField(viewModel: .init(label: "Phone",
                                                      text: $viewModel.phone,
                                                      fieldType: .phone,
                                                      editingField: $viewModel.editingField,
                                                      onCommit: { viewModel.updateUserData(field: .phone) }))
                    .submitLabel(.done)
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)

                    Button("Sign Out") {
                        viewModel.signOut()
                    }
                    .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .padding()
                    .frame(width: 310, height: 50)
                    .background(.purple.opacity(colorScheme == .dark ? 1 : 0.6))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding()

                    Spacer()
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchCurrentUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(appRootManager: AppRootManager(),
                                                authenticationProvider: AuthenticationRepositoryMock(),
                                                usersProvider: UserRepositoryMock()))
    }
}
