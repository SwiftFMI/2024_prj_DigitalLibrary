//
//  FirebaseConfiguration.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 28.01.24.
//

import FirebaseCore

final class FirebaseConfiguration {
    private static var isConfigured = false
    
    static func configure() {
        if !isConfigured {
            FirebaseApp.configure()

            isConfigured = true
        }
    }
}
