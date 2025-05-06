//
//  AudioPlayerManager.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import AVFoundation
import Combine
import SwiftUI

class AudioPlayerManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var progress: Float = 0
    @Published var currentTitle: String = ""

    private var player: AVPlayer?
    private var timeObserverToken: Any?
    private var statusObserver: NSKeyValueObservation?

    init() {
        setupAudioSession()
    }

    private func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("Audio session error:", error)
        }
    }

    /// Stream & play from any remote or local URL
    func play(url: URL, title: String) {
        // Tear down old player
        stopObservers()

        currentTitle = title
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)

        // Observe when the duration is loaded
        statusObserver = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            guard item.status == .readyToPlay else { return }
            let secs = CMTimeGetSeconds(item.asset.duration)
            DispatchQueue.main.async {
                self?.duration = secs.isFinite ? secs : 0
            }
        }

        // Add periodic time observer to update currentTime & progress
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            let secs = CMTimeGetSeconds(time)
            self.currentTime = secs
            if self.duration > 0 {
                self.progress = Float(secs / self.duration)
            }
        }

        // Observe end-of-playback
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(itemDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item
        )

        // Start playback
        player?.play()
        isPlaying = true
    }

    @objc private func itemDidFinishPlaying(_ notification: Notification) {
        isPlaying = false
        seek(to: 0)
    }

    func togglePlayPause() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }

    func stop() {
        player?.pause()
        seek(to: 0)
        isPlaying = false
    }

    func seek(to time: TimeInterval) {
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.seek(to: cmTime)
    }

    private func stopObservers() {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
        statusObserver?.invalidate()
        statusObserver = nil
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        stopObservers()
    }
}
