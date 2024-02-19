//
//  MyBooksView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct MyBooksView: View {
    @ObservedObject var viewModel: MyBooksViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.readingBooks.isEmpty {
                    EmptyLibraryView()
                } else {
                    VStack {
                        List(viewModel.readingBooks, id: \.self) { book in
                            NavigationLink(destination: BookDetailsView(viewModel:
                                    .init(book: book,
                                          booksProvider: viewModel.booksProvider,
                                          userProvider: viewModel.userProvider,
                                          authenticationProvider: viewModel.authenticationProvider)
                            )) {
                                BookListCell(book: book)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }

                    VStack {
                        List(viewModel.unfinishedBooks, id: \.self) { book in
                            NavigationLink(destination: BookDetailsView(viewModel:
                                    .init(book: book,
                                          booksProvider: viewModel.booksProvider,
                                          userProvider: viewModel.userProvider,
                                          authenticationProvider: viewModel.authenticationProvider)
                            )) {
                                BookListCell(book: book)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(.purple.opacity(0.4))
                        Text("My Books")
                            .font(.headline)
                            .foregroundColor(.purple.opacity(0.6))
                    }
                }
            }
            .padding(.bottom, 16)
            .onAppear {
                viewModel.getAllReadingBooks()
            }
        }
        .accentColor(.purple)
    }
}
