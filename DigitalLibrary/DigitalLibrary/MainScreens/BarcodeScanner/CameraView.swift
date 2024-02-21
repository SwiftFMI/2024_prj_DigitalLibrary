//
//  CameraView.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 19.02.24.
//

import SwiftUI
import VisionKit

struct CameraView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showAlert: Bool = false
    @State var isShowingScanner = true
    @State var showRectangle: Bool = true
    @Binding var isScanning: Bool
    @Binding var scannedText: String
    var books: [Book]

    var body: some View {
        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            ZStack {
                DataScannerRepresentable(
                    shouldStartScanning: $isShowingScanner,
                    scannedText: $scannedText,
                    dataToScanFor: [.barcode(symbologies: [.ean13])]
                )

                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 300, height: 200)
                    .overlay(
                        Text("Tap on the barcode to scan it")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .opacity(0.5)
                    )
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)
                    .onTapGesture {
                        showRectangle = false
                    }
                    .opacity(showRectangle ? 1 : 0)

                if scannedText != "" {
                    VStack {
                        Text("Tap on the correct ISBN below")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .opacity(0.7)
                            .frame(width: 200)
                            .padding(.bottom, 40)

                        Text(scannedText)
                            .background(colorScheme == .dark ? .white : .black)
                            .foregroundColor(.primary)
                            .onTapGesture {
                                let filteredBooks = books.filter { $0.isbn.localizedCaseInsensitiveContains(scannedText) }
                                if filteredBooks.count == 0 {
                                    showAlert = true
                                }
                                else {
                                    isScanning = false
                                }
                            }
                    }
                }
            }
            .alert("There isn't a book with this ISBN.", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    isScanning = false
                }
            }
        } else if !DataScannerViewController.isSupported {
            Text("It looks like this device doesn't support the DataScannerViewController")
                .multilineTextAlignment(.center)
        } else {
            Text("It appears your camera may not be available")
                .multilineTextAlignment(.center)
        }
    }
}
