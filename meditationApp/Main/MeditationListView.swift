//
//  MeditationListView.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 06.05.2025.
//
import SwiftUI

struct MeditationListView: View {
    let course: MeditationCourse
    @ObservedObject var audioPlayer: AudioPlayerManager
    let router: MeditationRouter

    @State private var showPlayer = false

    var body: some View {
        VStack(spacing: 0) {
            // ───────────────────────────────────────────────────
            // Custom Nav–Bar with Back Button
            HStack {
                Button(action: {
                    router.goBack()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                      
                    }
                    .foregroundColor(.primary)
                }
                .padding(.leading, 16)

                Spacer()
            }
            .padding(.vertical, 10)
        

            // ───────────────────────────────────────────────────
            // List of Meditations
            List {
                Section(header:
                    Text(course.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                ) {
                    ForEach(course.meditations) { meditation in
                        Button(action: {
                            guard let url = URL(string: meditation.audioURL) else { return }
                            audioPlayer.play(url: url, title: meditation.title)
                            showPlayer = true
                        }) {
                            MeditationRow(meditation: meditation)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())

            // ───────────────────────────────────────────────────
            // Bottom Audio Player
            if showPlayer {
                AudioPlayerView(audioPlayer: audioPlayer)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: audioPlayer.isPlaying)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
