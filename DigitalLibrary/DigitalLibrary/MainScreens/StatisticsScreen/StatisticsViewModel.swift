//
//  StatisticsViewModel.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import Foundation

enum ChartType {
    case forTime
    case forGenre
    case forAuthor
}

final class StatisticsViewModel: ObservableObject {
    @Published var books: [Book] = Array(BooksMockData.books.prefix(10)) // change later
}
