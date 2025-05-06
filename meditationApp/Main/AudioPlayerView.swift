//
//  AudioPlayerView.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import SwiftUI

struct AudioPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayerManager
    
    var body: some View {
        VStack {
            Text(audioPlayer.currentTitle)
                .font(.headline)
                .padding(.bottom, 8)
            
            // Time indicators
            HStack {
                Text(formatTime(audioPlayer.currentTime))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(formatTime(audioPlayer.duration))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Progress slider
            Slider(value: Binding(
                get: { Float(audioPlayer.currentTime) },
                set: { audioPlayer.seek(to: TimeInterval($0)) }
            ), in: 0...Float(max(1, audioPlayer.duration)))
            .accentColor(Color("#8A8AFF"))
            
            // Control buttons
            HStack(spacing: 40) {
                Button(action: {
                    audioPlayer.seek(to: max(0, audioPlayer.currentTime - 15))
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    audioPlayer.togglePlayPause()
                }) {
                    Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(Color("#8A8AFF"))
                }
                
                Button(action: {
                    audioPlayer.seek(to: min(audioPlayer.duration, audioPlayer.currentTime + 15))
                }) {
                    Image(systemName: "goforward.15")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
