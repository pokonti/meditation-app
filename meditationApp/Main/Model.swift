//
//  Model.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import Foundation
import SwiftUICore

struct MeditationCourse: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let duration: String
    let image: Image
    var meditations: [Meditation]
}

struct Meditation: Identifiable {
    let id: String
    let title: String
    let duration: String
    let audioURL: String
}


