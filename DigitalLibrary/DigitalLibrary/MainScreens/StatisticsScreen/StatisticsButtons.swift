//
//  StatisticsButtons.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 18.02.24.
//

import SwiftUI

struct StatisticsButtons: View {
    @ObservedObject var viewModel: StatisticsButtonsViewModel

    var body: some View {
        HStack(spacing: 0) {
            StatisticsSingleButton(viewModel: StatisticsSingleButtonViewModel(
                title: "Time",
                isActive: viewModel.timeButtonIsTapped) {
                    viewModel.timeButtonIsTapped = true
                    viewModel.genreButtonIsTapped = false
                    viewModel.authorButtonIsTapped = false
                    viewModel.chartType = .forTime
                })

            StatisticsSingleButton(viewModel: StatisticsSingleButtonViewModel(
                title: "Genre",
                isActive: viewModel.genreButtonIsTapped) {
                    viewModel.timeButtonIsTapped = false
                    viewModel.genreButtonIsTapped = true
                    viewModel.authorButtonIsTapped = false
                    viewModel.chartType = .forGenre
                })

            StatisticsSingleButton(viewModel: StatisticsSingleButtonViewModel(
                title: "Author",
                isActive: viewModel.authorButtonIsTapped) {
                    viewModel.timeButtonIsTapped = false
                    viewModel.genreButtonIsTapped = false
                    viewModel.authorButtonIsTapped = true
                    viewModel.chartType = .forAuthor
                })
        }
    }
}

struct StatisticsSingleButton: View {
    @ObservedObject var viewModel: StatisticsSingleButtonViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: {
            viewModel.isActive = true
            viewModel.actionHandler()
        }) {
            Text(viewModel.title)
                .padding(15)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .background(.clear)
                .font(viewModel.isActive ? .title3 : .callout)
                .underline(viewModel.isActive)
                .bold()
        }
    }
}
