//
//  CourseCard.swift
//  meditationApp
//
//  Created by Firuza on 08.05.2025.
//

import SwiftUI

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
