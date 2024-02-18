//
//  StatisticsBarChartViewModel.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import Foundation

final class StatisticsBarChartViewModel: ObservableObject {
    @Published var books: [Book]
    @Published var xAxisTitle: String

    init(books: [Book], xAxisTitle: String) {
        self.books = books
        self.xAxisTitle = xAxisTitle
    }
}
