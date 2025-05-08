//
//  AppDelegate.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//

import UIKit
import SwiftUI
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: – App launch
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Инициализируем Firebase
        FirebaseApp.configure()
        // Запрашиваем разрешение на локальные уведомления
        NotificationManager.shared.requestAuthorization()
        return true
    }

    // MARK: – UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Возвращаем стандартную конфигурацию сцены
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Здесь можно почистить данные для отброшенных сцен
    }
}
