//
//  ProfileInfoFieldViewModel.swift
//  DigitalLibrary
//
//  Created by Ognyan Yonchev on 20.02.24.
//

import SwiftUI

class ProfileInfoFieldViewModel: ObservableObject {
    let label: String
    let fieldType: ProfileField
    @Binding var text: String
    @Binding var editingField: ProfileField?
    let onCommit: () -> Void

    init(label: String,
         text: Binding<String>,
         fieldType: ProfileField,
         editingField: Binding<ProfileField?>,
         onCommit: @escaping () -> Void) {
        self.label = label
        self.fieldType = fieldType
        self._text = text
        self._editingField = editingField
        self.onCommit = onCommit
    }

    var isEditing: Bool {
        editingField == fieldType
    }
}
