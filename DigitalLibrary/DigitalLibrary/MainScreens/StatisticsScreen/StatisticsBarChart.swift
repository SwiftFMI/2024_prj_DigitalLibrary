//
//  StatisticsBarChart.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 18.02.24.
//

import Charts
import SwiftUI

struct StatisticsBarChart: View {
    @ObservedObject var viewModel: StatisticsBarChartViewModel

    var body: some View {
        Chart {
            ForEach(viewModel.books) { book in
                BarMark(x: .value("xAxisTitle", viewModel.xAxisTitle == "Author" ? book.author : book.genre ?? ""),
                        y: .value("Books count", 1))
                    .cornerRadius(10)
                    .annotation {
                        Text(String(viewModel.books.filter { book1 in
                            if viewModel.xAxisTitle == "Author" {
                                return book1.author == book.author
                            } else {
                                return book1.genre == book.genre
                            }
                        }.count))
                    }
            }
        }
        .chartYAxis(.hidden)
        .chartYAxisLabel(position: .trailing, alignment: .center) {
            Text("Books count")
                .foregroundColor(.black)
                .font(.body)
                .bold()
        }
        .chartYAxisLabel(position: .top, alignment: .center) {
            Text(viewModel.xAxisTitle)
                .foregroundColor(.black)
                .font(.body)
                .bold()
        }
        .shadow(color: .gray, radius: 10, x: 10)
        .padding()
        .foregroundColor(Color(red: 141 / 255, green: 87 / 255, blue: 138 / 255))
    }
}
