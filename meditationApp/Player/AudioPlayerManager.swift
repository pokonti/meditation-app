//
//  AudioPlayerManager.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//


import Foundation
import AVFoundation

class AudioPlayerManager: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    func start(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        player = AVPlayer(url: url)
        if let asset = player?.currentItem?.asset {
            duration = asset.duration.seconds
        }
        addObserver()
        player?.play()
        isPlaying = true
    }
    
    func togglePlayPause(urlString: String) {
        guard let p = player else {
            start(urlString: urlString)
            return
        }
        if isPlaying {
            p.pause()
            isPlaying = false
        } else {
            p.play()
            isPlaying = true
        }
    }
    
    func rewind15() {
        guard let p = player else { return }
        let t = max(p.currentTime().seconds - 15, 0)
        p.seek(to: CMTime(seconds: t, preferredTimescale: 1))
    }
    func forward15() {
        guard let p = player else { return }
        let t = min(p.currentTime().seconds + 15, duration)
        p.seek(to: CMTime(seconds: t, preferredTimescale: 1))
    }
    
    private func addObserver() {
        guard let p = player else { return }
        timeObserver = p.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: .main
        ) { [weak self] t in
            self?.currentTime = t.seconds
        }
    }
    
    deinit {
        if let obs = timeObserver {
            player?.removeTimeObserver(obs)
        }
    }
}
