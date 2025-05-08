//
//  RecommendedCard.swift
//  meditationApp
//
//  Created by Firuza on 08.05.2025.
//

import SwiftUI

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
