//
//  EditableProfileImage.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 21.02.24.
//

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    @Environment(\.colorScheme) var colorScheme

    let viewModel: ProfileModel

    var body: some View {
        switch viewModel.imageState {
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(50)
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(50)
                .foregroundColor(.purple.opacity(colorScheme == .dark ? 1 : 0.6))
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(50)
                .foregroundColor(.white)
        }
    }
}

struct EditableProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ProfileImage(viewModel: viewModel)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
