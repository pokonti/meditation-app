//
//  DiaryListView.swift
//  meditationApp
//
//  Created by Firuza on 06.05.2025.
//
import SwiftUI
import Charts

struct DiaryListView: View {
    @ObservedObject var viewModel: DiaryViewModel
    @State private var showAddSheet = false

    private let moodEmojis = ["😞","😐","🙂","😃","🤩"]
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMMM yyyy"
        return df
    }()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("How are you feeling today? Share it!")
                        .font(.largeTitle).bold()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)

                // Weekly mood chart
                Chart {
                    ForEach(viewModel.weeklyMoodSeries, id: \.date) { point in
                        LineMark(
                            x: .value("Day", point.date, unit: .day),
                            y: .value("Mood", point.mood)
                        )
                        PointMark(
                            x: .value("Day", point.date, unit: .day),
                            y: .value("Mood", point.mood)
                        )
                    }
                }
                .chartYScale(domain: 0...4)
                .frame(height: 140)
                .padding(.horizontal)

                // Today's mood badge
                if let today = viewModel.entries.first(where: { Calendar.current.isDateInToday($0.date) }) {
                    HStack {
                        Text("Today's Mood:")
                            .font(.headline)
                        Text(moodEmojis[today.mood])
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                // Entries list
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.entries) { entry in
                            DiaryEntryCard(
                                entry: entry,
                                moodEmoji: moodEmojis[entry.mood],
                                dateString: dateFormatter.string(from: entry.date)
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
            }
            .overlay(
                // Floating "+" button
                Button(action: { showAddSheet = true }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(.siren)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.bottom, 30)
                .padding(.trailing, 20),
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showAddSheet) {
                AddDiaryEntryView(viewModel: viewModel)
            }
            .navigationBarHidden(true)
        }
    }
}

struct DiaryEntryCard: View {
    let entry: DiaryEntry
    let moodEmoji: String
    let dateString: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(entry.title)
                    .font(.headline)
                Spacer()
                Text(moodEmoji)
                    .font(.title2)
            }

            Text(entry.content)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(2)

            HStack {
                Text(dateString)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}
