//
//  DiaryViewModel.swift
//  meditationApp
//
//  Created by Firuza on 06.05.2025.
//

import Foundation

final class DiaryViewModel: ObservableObject {
    @Published private(set) var entries: [DiaryEntry] = []

    init() {
        // Example initial entry
        entries = [
            DiaryEntry(
                title: "Paw Prints Through Périgueux",
                content: "What an enchanting day in Périgueux! The cobblestone streets whispered ancient tales …",
                date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!,
                mood: 3
            )
        ]
    }

    func addEntry(title: String, content: String, mood: Int) {
        let new = DiaryEntry(title: title, content: content, date: Date(), mood: mood)
        entries.insert(new, at: 0)
    }

    /// Average mood per day for the last 7 days
    var weeklyMoodSeries: [(date: Date, mood: Double)] {
        let calendar = Calendar.current
        let today = Date()
        return (0..<7).compactMap { offset in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            let sameDay = entries.filter { calendar.isDate($0.date, inSameDayAs: day) }
            let avg = sameDay.isEmpty
                ? 0
                : sameDay.map { Double($0.mood) }.reduce(0, +) / Double(sameDay.count)
            return (date: day, mood: avg)
        }
        .reversed()
    }
}
