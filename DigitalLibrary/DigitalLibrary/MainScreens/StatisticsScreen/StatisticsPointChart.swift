//
//  StatisticsPointChart.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 18.02.24.
//

import Charts
import SwiftUI

struct StatisticsPointChart: View {
    @ObservedObject var viewModel: StatisticsPointChartViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Chart {
            ForEach(viewModel.books.sorted(by: { book1, book2 in
                book1.returningDeadline ?? Date() < book2.returningDeadline ?? Date()
            }), id: \.self) { book in
                PointMark(x: .value("Deadline", book.returningDeadline ?? Date()),
                          y: .value("Book", book.title))
                    .annotation(position: .trailing, alignment: .leading) {
                        Text((book.returningDeadline ?? Date()).formatForStatistics())
                            .font(.footnote)
                            .foregroundColor(book.returningDeadline?.formatForStatistics() == Date().formatForStatistics() ? .red : (colorScheme == .dark ? .white : .black))

                    }
            }
        }
        .chartYAxisLabel(position: .top, alignment: .center) {
            Text("Returning date")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.body)
                .bold()
        }
        .chartXScale(domain: [Date(), Calendar.current.date(byAdding: .weekOfYear, value: 4, to: Date()) ?? Date()])
        .padding()
        .foregroundColor(Color(red: 141 / 255, green: 87 / 255, blue: 138 / 255))
    }
}
