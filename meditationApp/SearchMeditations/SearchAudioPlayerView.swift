//
//  SearchAudiPlayerView.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//


import SwiftUI

struct SearchAudioPlayerView: View {
    let meditation: Meditation
    @ObservedObject var player: SearchAudioPlayerManager

    @EnvironmentObject var favs: FavoritesViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.white, .blue.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.7)))
                    }
                    Spacer()
                    Button { favs.toggle(meditation.id) } label: {
                        Image(
                          systemName: favs.isFavorite(meditation.id)
                            ? "heart.fill"
                            : "heart"
                        )
                        .foregroundColor(.red)
                        .padding()
                        .background(Circle().fill(Color.white.opacity(0.7)))
                    }
                }
                .padding(.horizontal)

                Spacer()

                Text(meditation.title)
                    .font(.title).bold()
                Text(meditation.theme.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                HStack(spacing: 60) {
                    Button { player.rewind15() } label: {
                        Image(systemName: "gobackward.15")
                            .font(.title2)
                    }
                    Button {
                        player.togglePlayPause(urlString: meditation.audioURL)
                    } label: {
                        Image(
                          systemName: player.isPlaying
                            ? "pause.circle.fill"
                            : "play.circle.fill"
                        )
                        .font(.system(size: 64))
                    }
                    Button { player.forward15() } label: {
                        Image(systemName: "goforward.15")
                            .font(.title2)
                    }
                }

                VStack {
                    Slider(
                        value: $player.currentTime,
                        in: 0...max(player.duration, 0.1),
                        onEditingChanged: { _ in }
                    )
                    HStack {
                        Text(timeString(player.currentTime))
                        Spacer()
                        Text(timeString(player.duration))
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .onAppear {
            player.start(urlString: meditation.audioURL)
        }
    }

    private func timeString(_ t: TimeInterval) -> String {
        let m = Int(t) / 60, s = Int(t) % 60
        return String(format: "%01d:%02d", m, s)
    }
}
