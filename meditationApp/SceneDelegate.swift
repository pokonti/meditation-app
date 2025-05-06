//
//  SceneDelegate.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        // 1. Для теста: планируем уведомление каждые 30 секунд
        NotificationManager.shared.scheduleTestReminder()
        // → когда будете готовы к ежедневному вечеру, замените на:
        // NotificationManager.shared.scheduleDailyReminder(hour: 20, minute: 0)

//        // 2. Создаём SwiftUI-контент
//        let contentView = MainView()
//
//        // 3. Помещаем его в окно
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UIHostingController(rootView: contentView)
//        self.window = window
//        window.makeKeyAndVisible()
        // 1. Create your UINavigationController
        let navController = UINavigationController()

        // 2. Create your shared services / VMs
        let audioPlayer = AudioPlayerManager()
        let router = MeditationRouter(rootViewController: navController, audioPlayer: audioPlayer)

        // 3. Pass the router into MainView
        let mainView = MainView(
            viewModel: ViewModel(),
            authVM: AuthViewModel(),
            diaryVM: DiaryViewModel(),
            audioPlayer: audioPlayer,
            router: router
        )

        // 4. Embed in a UIHostingController and set as root
        let hosting = UIHostingController(rootView: mainView)
        navController.viewControllers = [hosting]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
