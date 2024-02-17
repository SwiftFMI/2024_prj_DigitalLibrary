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
                                    .init(book: book, booksProvider: viewModel.booksProvider)
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
                        Text("All Books")
                            .font(.headline)
                            .foregroundColor(.purple.opacity(0.6))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // The scanner screen is attached here
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
