//
//  SearchBar.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 17.02.24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    @Binding var selectedScope: Int
    let scopeButtonTitles = ["All", "Author", "Publisher", "Year"]

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $text)
                    .padding(10)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .autocorrectionDisabled()
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        }
                    )

                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }

            Picker(selection: $selectedScope, label: Text("Scope")) {
                ForEach(0..<scopeButtonTitles.count, id: \.self) { index in
                    Text(scopeButtonTitles[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
        }
    }
}
