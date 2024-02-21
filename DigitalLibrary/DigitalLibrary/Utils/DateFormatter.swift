//
//  DateFormatter.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 18.02.24.
//

import Foundation

extension Date {
    func formatForStatistics() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: self)
    }

    func formatForBookView() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }

    func timestamp() -> String {
        "\(self.timeIntervalSince1970)"
    }
}
