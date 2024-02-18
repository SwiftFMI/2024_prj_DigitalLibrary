//
//  StatisticsPointChartViewModel.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import Foundation

final class StatisticsPointChartViewModel: ObservableObject {
    @Published var books: [Book]

    init(books: [Book]) {
        self.books = books
    }
}
