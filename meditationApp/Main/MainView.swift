//
//  View.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
// MainView.swift

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: ViewModel
    @StateObject var authVM: AuthViewModel
    @StateObject var diaryVM: DiaryViewModel
    @StateObject var audioPlayer: AudioPlayerManager
    let router: MeditationRouter
    @State private var selectedTab = 0

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                TabView(selection: $selectedTab) {
                    // Home tab
                    HomeView(
                        viewModel: viewModel,
                        audioPlayer: audioPlayer,
                        authVM: authVM,
                        router: router
                    )
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)

                    // Other tabs...
                    Text("Search")
                        .tabItem { Image(systemName: "magnifyingglass"); Text("Search") }
                        .tag(1)

                    Text("Favorites")
                        .tabItem { Image(systemName: "heart"); Text("Favorites") }
                        .tag(2)

                    DiaryListView(viewModel: diaryVM)
                        .tabItem { Image(systemName: "book"); Text("Diary") }
                        .tag(3)

                    MeView(authVM: authVM)
                        .tabItem { Image(systemName: "person"); Text("Me") }
                        .tag(4)
                }
                .accentColor(.siren)
            } else {
                LoginView(authVM: authVM)
            }
        }
        .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}
