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
        
        // Инициализируем службы
        let authVM      = AuthViewModel()
        let audioPlayer = AudioPlayerManager()
        let diaryVM     = DiaryViewModel()
        let navController = UINavigationController()
        let favoritesVM = FavoritesViewModel()
        
        // Создаём AppRouter и стартуем с логина
        let router = AppRouter(
            navController: navController,
            authVM: authVM,
            audioPlayer: audioPlayer,
            diaryVM: diaryVM,
            favoritesVM: favoritesVM
        )
        let main = MainView(
            viewModel: ViewModel(),
            authVM: authVM,
            diaryVM: diaryVM,
            audioPlayer: audioPlayer
        )
        .environmentObject(router)
        .environmentObject(favoritesVM)
        
        let hosting = UIHostingController(rootView: main)
        navController.viewControllers = [hosting]
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}
