//
//  FavouritesView.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 11.05.2025.
//

import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject var authVM: AuthViewModel
  @EnvironmentObject var favoritesVM: FavoritesViewModel

  @State private var favMeditations: [Meditation] = []
  @State private var isLoading = false
  @State private var error: Error?

  var body: some View {
    VStack {
      Text("Favorites")
        .font(.largeTitle).bold()
        .padding(.top)

      if isLoading {
        ProgressView().padding()
      }
      else if let err = error {
        Text("Error: \(err.localizedDescription)")
          .foregroundColor(.red)
          .padding()
      }
      else if favMeditations.isEmpty {
        Text("No favorites yet.")
          .foregroundColor(.gray)
          .padding()
      }
      else {
        List(favMeditations) { m in
          HStack {
            Image(systemName: "play.circle.fill")
              .font(.largeTitle)
            VStack(alignment: .leading) {
              Text(m.title)
              Text("\(Int(m.duration)) min")
                .font(.caption)
                .foregroundColor(.gray)
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
              router.showSearchAudioPlayer(for: m)
          }
        }
      }
    }
    .onAppear {
      Task { await loadFavoritesMeditations() }
    }
  }

  private func loadFavoritesMeditations() async {
    isLoading = true
    error = nil
    favMeditations = []

      guard authVM.currentUserID != nil else {
      isLoading = false
      return
    }

    await favoritesVM.loadFavorites()
    do {
      var loaded: [Meditation] = []
      for idStr in favoritesVM.favorites {
        if let id = Int(idStr) {
          let med = try await MeditationAPI.shared
            .getMeditation(meditationID: id)
          loaded.append(med)
        }
      }
      favMeditations = loaded
    } catch {
      self.error = error
    }

    isLoading = false
  }
}
