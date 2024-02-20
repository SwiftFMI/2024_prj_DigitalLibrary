//
//  LibraryView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: LibraryViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        SearchBar(text: $viewModel.searchText,
                                  isSearching: $viewModel.isSearching,
                                  selectedScope: $viewModel.selectedScope)

                        List(viewModel.filteredBooks, id: \.self) { book in
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

                if viewModel.scannedText != "" {
                    Text("")
                        .hidden()
                        .task {
                            let books = viewModel.books.filter { $0.isbn.localizedCaseInsensitiveContains(viewModel.scannedText) }
                            if books.count > 0 {
                                let bookTitle = books.first?.title
                                viewModel.searchText = bookTitle ?? ""
                                viewModel.selectedScope = 0
                            } else {
                                viewModel.searchText = ""
                            }
                        }
                }
            }
            .sheet(isPresented: $viewModel.isScanning) {
                CameraView(isScanning: $viewModel.isScanning, scannedText: $viewModel.scannedText, books: viewModel.books)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(.purple.opacity(0.4))
                        Text("All Books")
                            .font(.headline)
                            .foregroundColor(.purple.opacity(0.6))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.scannedText = ""
                        viewModel.isScanning = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundColor(.purple.opacity(0.6))
                    }
                }
            }
            .padding(.bottom, 16)
            .onAppear {
                viewModel.getAllBooks()
            }
        }
        .accentColor(.purple)
    }
}
