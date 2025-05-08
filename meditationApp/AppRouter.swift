//
//  Router.swift
//  meditationApp
//
//  Created by Firuza on 08.05.2025.
//
import SwiftUI
import UIKit

final class AppRouter: ObservableObject {
    private weak var navController: UINavigationController?
    let authVM: AuthViewModel
    let audioPlayer: AudioPlayerManager
    let diaryVM: DiaryViewModel

    init(
        navController: UINavigationController,
        authVM: AuthViewModel,
        audioPlayer: AudioPlayerManager,
        diaryVM: DiaryViewModel
    ) {
        self.navController = navController
        self.authVM       = authVM
        self.audioPlayer  = audioPlayer
        self.diaryVM      = diaryVM
        showLogin()
    }

    func showLogin() {
        let view = LoginView(authVM: authVM)
            .environmentObject(self)
        let vc = UIHostingController(rootView: view)
        navController?.setViewControllers([vc], animated: false)
    }


    func showRegister() {
        let view = RegisterView(authVM: authVM)
            .environmentObject(self)
        let vc = UIHostingController(rootView: view)
        navController?.pushViewController(vc, animated: true)
    }

    func showMain() {
        let view = MainView(
            viewModel: ViewModel(),
            authVM: authVM,
            diaryVM: diaryVM,
            audioPlayer: audioPlayer
        )
        .environmentObject(self)
        let vc = UIHostingController(rootView: view)
        navController?.setViewControllers([vc], animated: true)
    }


    func showMeditationList(for course: MeditationCourse) {
        let view = MeditationListView(
            course: course,
            audioPlayer: audioPlayer
        )
        .environmentObject(self)
        let vc = UIHostingController(rootView: view)
        navController?.pushViewController(vc, animated: true)
    }

    func goBack() {
        navController?.popViewController(animated: true)
    }
}

