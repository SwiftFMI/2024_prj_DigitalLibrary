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
            if let photo = viewModel.photo,
               let image = UIImage(data: photo) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 25)
            } else {
                Image("default_book_cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 25)
            }

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

            if let returningDeadline = viewModel.returningDeadline {
                Text("Returning date: \(returningDeadline.formatForBookView())")
                    .font(.headline)
                    .foregroundColor(.red.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15)
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(viewModel: .init(book: BooksMockData.books[0],
                                         booksProvider: BooksRepositoryMock(),
                                         userProvider: UserRepositoryMock(),
                                         authenticationProvider: AuthenticationRepositoryMock()))
    }
}
