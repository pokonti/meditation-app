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
        Group{
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading courses...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Good Morning, \(authVM.userName)")
                                    .font(.title).fontWeight(.semibold)
                                Text("We wish you a good day")
                                    .font(.subheadline).foregroundColor(.cyan)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.courses.prefix(4)) { course in
                                CourseCard(course: course)
                                    .onTapGesture {
                                        router.showMeditationList(for: course)
                                    }
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recommended courses")
                                .font(.title3)
                                .bold()
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.courses.suffix(3)) { course in
                                        RecommendedCard(course: course)
                                            .onTapGesture {
                                                router.showMeditationList(for: course)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                    }
                    .padding(.vertical)
                }
                .navigationBarHidden(true)
                .onAppear {
                    if viewModel.courses.isEmpty {
                        Task { await viewModel.loadSections()
                        }
                    }
                }
            }
            
        }
        
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
        ZStack(alignment: .bottomLeading) {
            course.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.01),
                            Color.black.opacity(0.5)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                )
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(course.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(course.duration)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 2)
                    
                    Text(course.subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)
                }
            }
            .padding(14)
        }
        .frame(width: 180, height: 100)
    
       
    }
}

