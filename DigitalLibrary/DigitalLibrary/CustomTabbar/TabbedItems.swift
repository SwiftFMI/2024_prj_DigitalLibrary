//
//  TabbedItems.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

enum TabbedItems: Int, CaseIterable {
    case library = 0
    case myBooks
    case statistics
    case profile

    var title: String {
        switch self {
        case .library:
            return "Library"
        case .myBooks:
            return "My Books"
        case .statistics:
            return "Statistics"
        case .profile:
            return "Profile"
        }
    }

    var iconName: String {
        switch self {
        case .library:
            return "library"
        case .myBooks:
            return "books"
        case .statistics:
            return "statistics"
        case .profile:
            return "user"
        }
    }
}
