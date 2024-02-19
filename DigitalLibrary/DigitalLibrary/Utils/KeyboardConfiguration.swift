//
//  KeyboardConfiguration.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 20.02.24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
