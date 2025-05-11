//
//  SearchAppRouter.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//
import UIKit
import SwiftUI

final class SearchAppRouter: ObservableObject {
    let navController: UINavigationController
    let authVM: AuthViewModel
    let audioPlayer: SearchAudioPlayerManager
    let diaryVM: DiaryViewModel
    let favoritesVM: FavoritesViewModel

    init(
      navController: UINavigationController,
      authVM: AuthViewModel,
      audioPlayer: SearchAudioPlayerManager,
      diaryVM: DiaryViewModel,
      favoritesVM: FavoritesViewModel
    ) {
        self.navController = navController
        self.authVM        = authVM
        self.audioPlayer   = audioPlayer
        self.diaryVM       = diaryVM
        self.favoritesVM   = favoritesVM
    }

    func showAudioPlayer(for meditation: Meditation) {
        let playerView = SearchAudioPlayerView(
            meditation: meditation,
            player: audioPlayer
        )
        .environmentObject(favoritesVM)

        let vc = UIHostingController(rootView: playerView)
        navController.pushViewController(vc, animated: true)
    }
}
