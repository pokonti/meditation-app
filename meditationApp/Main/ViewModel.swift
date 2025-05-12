//
//  ViewModel.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var courses: [MeditationCourse] = []
    @Published var selectedCourse: MeditationCourse?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true
    
    init() {
        Task {
            await loadSections()
        }
    }

    func loadSections() async {
        isLoading = true
        do {
            let fetchedCourses = try await MeditationAPI.shared.fetchSections()
            print("Fetched sections:", fetchedCourses.count)
            self.courses = fetchedCourses
            
        } catch {
            print("Failed to fetch sections:", error)
            errorMessage = "Failed to load sections: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func selectCourse(_ course: MeditationCourse) {
        selectedCourse = course
    }
}
