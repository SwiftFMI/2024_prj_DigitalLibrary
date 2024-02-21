//
//  RememberMeView.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 21.02.24.
//

import SwiftUI

struct RememberMeView: View {
    @Binding private var isChecked: Bool

    init(isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }

    var body: some View {
        HStack(spacing: 10) {
            if isChecked {
                Image(systemName: "checkmark.square")
            } else {
                Image(systemName: "square")
            }
            Text("Remember me")
        }.onTapGesture {
            isChecked.toggle()
        }
    }
}

struct RememberMeView_Previews: PreviewProvider {
    @State private static var isChecked = false

    static var previews: some View {
        RememberMeView(isChecked: $isChecked)
    }
}
