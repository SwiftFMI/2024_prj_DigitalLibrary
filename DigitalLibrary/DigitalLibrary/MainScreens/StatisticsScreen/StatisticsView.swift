//
//  StatisticsView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import Charts
import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    @StateObject var statisticsButtonsViewModel = StatisticsButtonsViewModel()

    var body: some View {
        VStack {
            StatisticsButtons(viewModel: statisticsButtonsViewModel)

            switch statisticsButtonsViewModel.chartType {
            case .forTime:
                StatisticsPointChart(viewModel: StatisticsPointChartViewModel(books: viewModel.readingBooks.map({ pair in
                    return pair.value
                })))
            case .forGenre:
                StatisticsBarChart(viewModel: StatisticsBarChartViewModel(books: viewModel.allBooks.map({ pair in
                    return pair.value
                }), xAxisTitle: "Genre"))
            case .forAuthor:
                StatisticsBarChart(viewModel: StatisticsBarChartViewModel(books: viewModel.allBooks.map({ pair in
                    return pair.value
                }), xAxisTitle: "Author"))
            }
        }
        .padding()
    }
}
