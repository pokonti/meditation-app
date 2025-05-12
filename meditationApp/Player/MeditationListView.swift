//
//  MeditationListView.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 06.05.2025.
//
import SwiftUI

struct MeditationListView: View {
    let course: MeditationCourse
    @ObservedObject var audioPlayer: AudioPlayerManager
    @State private var showPlayer = false
    
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    router.goBack()
                } label: {
                    Image(systemName: "chevron.left").foregroundColor(.primary)
                }
                .padding(.leading, 16)
                Spacer()
               Button {
                favoritesVM.toggleFavorite(courseID: course.id)
               } label: {
                   Image(systemName: favoritesVM.isFavorite(courseID: course.id) ? "heart.fill" : "heart")
                       .font(.title2)
                       .foregroundColor(.white)
                       .padding()
                       .background(.siren)
                       .clipShape(Circle())
                       .shadow(radius: 1)
               }
               .padding(.trailing, 16)
                
            }
            .padding(.vertical, 10)

            List {
                Section(
                    header: Text(course.title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 8)
                ) {
                    ForEach(course.meditations) { meditation in
                        Button {
                            router.showAudioPlayer(for: meditation)
                        } label: {
                            MeditationRow(meditation: meditation)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
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
                Text(meditation.durationString)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
