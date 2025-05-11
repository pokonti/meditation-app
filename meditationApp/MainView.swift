//
//  View.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
// MainView.swift

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var authVM: AuthViewModel
    @ObservedObject var diaryVM: DiaryViewModel
    @ObservedObject var audioPlayer: AudioPlayerManager

    @EnvironmentObject var router: AppRouter
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
              viewModel: viewModel,
              audioPlayer: audioPlayer,
              authVM: authVM
            )
            .tabItem { Image(systemName: "house.fill"); Text("Home") }
            .tag(0)

            SearchView()
                .environmentObject(router)
                .tabItem { Image(systemName: "magnifyingglass"); Text("Search") }
                .tag(1)

            FavoritesView()
                .environmentObject(router)
                .tabItem { Image(systemName: "heart"); Text("Favorites") }
                .tag(2)

            DiaryListView(viewModel: diaryVM)
                .tabItem { Image(systemName: "book"); Text("Diary") }
                .tag(3)

            MeView(authVM: authVM)
                .tabItem { Image(systemName: "person"); Text("Me") }
                .tag(4)
        }
        .accentColor(.purple)
    }
}
