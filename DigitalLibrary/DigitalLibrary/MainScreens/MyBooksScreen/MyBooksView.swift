//
//  MyBooksView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct MyBooksView: View {
    @ObservedObject var viewModel: MyBooksViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.readingBooks.isEmpty && viewModel.readBooks.isEmpty {
                    EmptyLibraryView()
                } else {
                    List {
                        Section(header: Text(viewModel.firstSectionHeader)) {
                            ForEach(Array(viewModel.readingBooks.values), id: \.self) { book in
                                BookListCell(book: book)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            viewModel.moveBookToHistory(book)
                                        } label: {
                                            Label("Return", systemImage: "arrowshape.turn.up.left")
                                        }
                                    }
                                    .tint(.purple.opacity(colorScheme == .dark ? 1 : 0.6))
                            }
                        }

                        Section(header: Text(viewModel.secondSectionHeader)) {
                            ForEach(Array(viewModel.readBooks.values), id: \.self) { book in
                                BookListCell(book: book)
                                    .swipeActions {
                                        Button {
                                            viewModel.bookToDelete = book
                                            viewModel.isShowingDeleteAlert = true
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .tint(.red)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(.purple.opacity(colorScheme == .dark ? 1 : 0.4))
                        Text("My Books")
                            .font(.headline)
                            .foregroundColor(.purple.opacity(colorScheme == .dark ? 1 : 0.6))
                    }
                }
            }
            .padding(.bottom, 16)
            .onAppear {
                viewModel.getAllBooks()
            }
            .alert(isPresented: $viewModel.isShowingDeleteAlert) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to remove this book from history?"),
                    primaryButton: .default(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete")) {
                        if let book = viewModel.bookToDelete {
                            viewModel.removeBookFromHistory(book)
                            viewModel.getAllBooks()
                        }
                    }
                )
            }
        }
        .accentColor(.purple)
    }
}
