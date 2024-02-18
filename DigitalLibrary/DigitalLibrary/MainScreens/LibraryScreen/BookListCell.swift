//
//  BookListCell.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 15.02.24.
//

import SwiftUI

struct BookListCell: View {
    let book: Book

    var body: some View {
        HStack {
            if let photo = book.photo,
               let image = UIImage(data: photo) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 90)
                        .cornerRadius(8)
                } else {
                    Image("default_book_cover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 90)
                        .cornerRadius(8)
                }

            VStack(alignment: .leading, spacing: 5) {
                Text(book.title)
                    .font(.title2)
                    .fontWeight(.medium)

                Text(book.author)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
        }
    }
}

struct BookListCell_Previews: PreviewProvider {
    static var previews: some View {
        BookListCell(book: BooksMockData.books[0])
    }
}
