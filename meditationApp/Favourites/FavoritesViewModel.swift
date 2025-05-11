//
//  FavoritesViewModel.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 11.05.2025.
//
import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoriteIDs: Set<String> = []

    func isFavorite(courseID: String) -> Bool {
        favoriteIDs.contains(courseID)
    }

    func toggleFavorite(courseID: String) {
        if favoriteIDs.contains(courseID) {
            favoriteIDs.remove(courseID)
        } else {
            favoriteIDs.insert(courseID)
        }
    }
}
