//
//  LibraryView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct LibraryView: View {
    @State private var books: [Book] = []
    private let booksProvider: BooksProvidable

    init(booksProvider: BooksProvidable) {
        self.booksProvider = booksProvider
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(books, id: \.self) { book in
                    Text(book.title)
                        .background(.red)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            Task {
                books = await booksProvider.getAll() ?? []
            }
        })
    }
}
