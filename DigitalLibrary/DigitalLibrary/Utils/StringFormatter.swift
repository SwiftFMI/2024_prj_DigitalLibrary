//
//  StringFormatter.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 21.02.24.
//

import Foundation

extension String {
    func formatUnixstampToDate() -> Date {
        let timeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: timeInterval!)
    }
}
