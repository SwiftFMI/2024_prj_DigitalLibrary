//
//  SwiftUIChangeRootViewApp.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 6.02.24.
//

import SwiftUI
import UserNotifications

@main
struct SwiftUIChangeRootViewApp: App {
    @StateObject private var appRootManager = AppRootManager()
    private let authenticationProvider: AuthenticationProvidable = AuthenticationRepository()
    private let userProvider: UserProvidable = UserRepository()
    private let booksProvider: BooksProvidable = BooksRepository()
    private let notificationDelegate = NotificationDelegate()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .login:
                    RootView(appRootManager: appRootManager,
                             authenticationProvider: authenticationProvider,
                             userProvider: userProvider)
                case .main:
                    MainTabbedView(authenticationProvider: authenticationProvider,
                                   userProvider: userProvider,
                                   booksProvider: booksProvider)
                }
            }
            .onAppear {
                UNUserNotificationCenter.current().delegate = notificationDelegate
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
