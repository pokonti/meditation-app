//
//  SearchMeditationsView.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//

import SwiftUI

struct SearchMeditationsView: View {
    let meditations: [Meditation]
    let isLoading: Bool
    let error: Error?

    @EnvironmentObject var router: AppRouter

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let err = error {
                Text("Error: \(err.localizedDescription)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(meditations) { m in
                    HStack(spacing: 16) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.blue.opacity(0.8))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(m.title).font(.headline)
                            Text("\(Int(m.duration)) MIN")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.showSearchAudioPlayer(for: m)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}


