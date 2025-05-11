//
//  FavouritesViewModel.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 11.05.2025.
//

import SwiftUI

//@MainActor
class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: Set<String> = []

    private let authVM: AuthViewModel

    init(authVM: AuthViewModel) {
        self.authVM = authVM
        Task { await loadFavorites() }
    }

    /// Load the user's favorites from backend
    func loadFavorites() async {
        guard let uid = authVM.currentUserID else { return }
        do {
            let favList = try await FavoritesAPI
                .shared
                .getFavorites(userID: uid)
            favorites = Set(favList)
        } catch {
            print("⚠️ Failed to load favorites:", error)
        }
    }

    /// Toggle favorite state (calls POST or DELETE)
    func toggle(_ meditationID: String) {
      guard let uid = authVM.currentUserID else { return }

      Task {
        do {
          if favorites.contains(meditationID) {
            _ = try await FavoritesAPI.shared
              .removeFavorite(userID: uid, meditationID: meditationID)
          } else {
            _ = try await FavoritesAPI.shared
              .addFavorite(userID: uid, meditationID: meditationID)
          }
          // tell SwiftUI “hey, we’re about to change”
          objectWillChange.send()
          favorites.formSymmetricDifference([meditationID])
        } catch {
          print("⚠️ Fav toggle failed:", error)
        }
      }
    }


    /// Check local cache
    func isFavorite(_ meditationID: String) -> Bool {
        favorites.contains(meditationID)
    }
}
