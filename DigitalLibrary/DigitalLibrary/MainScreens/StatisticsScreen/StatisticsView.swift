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
                StatisticsPointChart(viewModel: StatisticsPointChartViewModel(books: viewModel.books))
            case .forGenre:
                StatisticsBarChart(viewModel: StatisticsBarChartViewModel(books: viewModel.books, xAxisTitle: "Genre"))
            case .forAuthor:
                StatisticsBarChart(viewModel: StatisticsBarChartViewModel(books: viewModel.books, xAxisTitle: "Author"))
            }
        }
        .padding()
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: StatisticsViewModel())
    }
}
