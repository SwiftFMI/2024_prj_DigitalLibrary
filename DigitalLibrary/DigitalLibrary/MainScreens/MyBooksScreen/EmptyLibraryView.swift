//
//  EmptyLibraryView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 20.02.24.
//

import SwiftUI

struct EmptyLibraryView: View {
    var body: some View {
        VStack {
            Image(systemName: "book.closed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("Your library is empty")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            Text("Start adding books to see them here!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
    }
}
