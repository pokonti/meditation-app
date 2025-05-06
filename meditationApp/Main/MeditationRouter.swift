//
//  MeditationRouter.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 06.05.2025.
//

import UIKit
import SwiftUI

final class MeditationRouter {
    /// The UINavigationController that will perform pushes
    weak var rootViewController: UINavigationController?
    let audioPlayer: AudioPlayerManager

    init(rootViewController: UINavigationController, audioPlayer: AudioPlayerManager) {
        self.rootViewController = rootViewController
        self.audioPlayer = audioPlayer
    }

    /// Pushes the SwiftUI list view for a given course
    func showMeditationList(for course: MeditationCourse) {
        let listView = MeditationListView(course: course,
                                                  audioPlayer: audioPlayer,
                                                  router: self)
        let vc = UIHostingController(rootView: listView)
        rootViewController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        rootViewController?.popViewController(animated: true)
    }
}

