//
//  BookDetailsView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 16.02.24.
//

import SwiftUI

struct BookDetailsView: View {
    @ObservedObject var viewModel: BookDetailsViewModel

    var body: some View {
        ScrollView {
            Image(viewModel.photo)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal, 80)
                .padding(.vertical, 25)
            
            VStack(spacing: 8) {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text(viewModel.author)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text("\(viewModel.publisher) \(viewModel.year)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(viewModel.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button(action: {
                viewModel.addToMyBooks()
            }) {
                Label(viewModel.buttonTitle, systemImage: viewModel.buttonImage)
                    .foregroundColor(viewModel.isTaken ? .purple.opacity(0.4) : .purple)
                    .padding()
            }
            .disabled(viewModel.isTaken)
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(viewModel: .init(book: BooksMockData.books[0],
                                         booksProvider: BooksRepository(),
                                         userProvider: UserRepository(),
                                         authenticationProvider: AuthenticationRepository()))
    }
}
