//
//  StatisticsButtonsViewModel.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import Foundation

final class StatisticsButtonsViewModel: ObservableObject {
    @Published var chartType: ChartType = .forTime
    @Published var timeButtonIsTapped: Bool = true
    @Published var genreButtonIsTapped: Bool = false
    @Published var authorButtonIsTapped: Bool = false

    init(chartType: ChartType = .forTime,
         timeButtonIsTapped: Bool = true,
         genreButtonIsTapped: Bool = false,
         authorButtonIsTapped: Bool = false) {
        self.chartType = chartType
        self.timeButtonIsTapped = timeButtonIsTapped
        self.genreButtonIsTapped = genreButtonIsTapped
        self.authorButtonIsTapped = authorButtonIsTapped
    }
}

final class StatisticsSingleButtonViewModel: ObservableObject {
    @Published var title: String
    @Published var isActive: Bool
    @Published var actionHandler: () -> Void

    init(title: String, isActive: Bool, actionHandler: @escaping () -> Void) {
        self.title = title
        self.isActive = isActive
        self.actionHandler = actionHandler
    }
}
