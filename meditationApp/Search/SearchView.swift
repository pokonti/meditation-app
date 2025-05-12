//
//  SearchView.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white.opacity(0.7))
                TextField("Search meditations", text: $vm.query)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .padding()

            if vm.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if let err = vm.error {
                Spacer()
                Text("Error: \(err.localizedDescription)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            } else if vm.meditations.isEmpty {
                Spacer()
                Text("No meditations found")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(vm.meditations) { m in
                    HStack(spacing: 16) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.blue.opacity(0.8))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(m.title).font(.headline)
                            Text("\(m.durationString)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.showAudioPlayer(for: m)
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear { Task { await vm.search() } }
        .onChange(of: vm.query) { _ in Task { await vm.search() } }
    }
}
