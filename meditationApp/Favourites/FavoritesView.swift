//
//  FavoritesView.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 11.05.2025.
//
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var audioPlayer: AudioPlayerManager

    @EnvironmentObject var router:      AppRouter
    @EnvironmentObject var favoritesVM: FavoritesViewModel

    private var favorites: [MeditationCourse] {
        viewModel.courses.filter { favoritesVM.isFavorite(courseID: $0.id) }
    }

    var body: some View {
        Group {
            if favorites.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("No favorites yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Tap the heart on any course to add it here.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(favorites) { course in
                    CourseCard(course: course)
                        .onTapGesture {
                            router.showMeditationList(for: course)
                        }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

