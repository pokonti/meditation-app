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
    @ObservedObject var authVM: AuthViewModel
    let router: MeditationRouter
    @State private var showPlayer = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Good Morning, \(authVM.userName)")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("We Wish you have a good day")
                            .font(.subheadline)
                            .foregroundColor(.cyan)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                // Grid of courses
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.courses.prefix(3)) { course in
                        CourseCard(course: course)
                            .onTapGesture {
                                router.showMeditationList(for: course)
                            }
                    }
                }
                .padding(.horizontal)

                // Recommended row
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

                // Bottom player
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


struct CourseCard: View {
    let course: MeditationCourse
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text(course.title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(course.subtitle)
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
            
            
            
            HStack {
                Text(course.duration)
                    .font(.caption)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("START")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(15)
            }
        }
        .padding()
        .frame(height: 180)
        .background(
              course.image
                .resizable()
                .scaledToFill()
            )
            .clipped()
        
        .cornerRadius(12)
    }
}

struct RecommendedCard: View {
    let course: MeditationCourse
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(width: 140, height: 100)
                .cornerRadius(12)
            
            Text(course.title)
                .font(.headline)
            
            Text("\(course.subtitle) • \(course.duration)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 140)
    }
}

struct MeditationRow: View {
    let meditation: Meditation
    
    var body: some View {
        HStack {
            Image(systemName: "play.circle.fill")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(meditation.title)
                    .fontWeight(.medium)
                
                Text(meditation.duration)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
