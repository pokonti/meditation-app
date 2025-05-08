//
//  HomeView.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var audioPlayer: AudioPlayerManager
    @EnvironmentObject var router: AppRouter
    @ObservedObject var authVM: AuthViewModel
    @State private var showPlayer = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Good Morning, \(authVM.userName)")    // ← теперь из authVM
                                            .font(.title).fontWeight(.semibold)
                        Text("We wish you a good day")
                            .font(.subheadline).foregroundColor(.cyan)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.courses.prefix(3)) { course in
                        CourseCard(course: course)
                            .onTapGesture {
                                router.showMeditationList(for: course)
                            }
                    }
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.courses.suffix(3)) { course in
                            RecommendedCard(course: course)
                                .onTapGesture {
                                    router.showMeditationList(for: course)
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                if showPlayer && audioPlayer.isPlaying {
                    AudioPlayerView(audioPlayer: audioPlayer)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showPlayer)
                }
            }
            .padding(.vertical)
        }
        .navigationBarHidden(true)
        .onAppear { showPlayer = audioPlayer.isPlaying }
    }
}
