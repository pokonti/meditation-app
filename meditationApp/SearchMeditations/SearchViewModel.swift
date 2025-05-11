//
//  SearchViewModel.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//


import Foundation

//@MainActor
class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var meditations: [Meditation] = []
    @Published var isLoading = false
    @Published var error: Error?

    func search() async {
            isLoading = true
            error = nil
            defer { isLoading = false }

            let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
            do {
                if trimmed.isEmpty {
                    meditations = try await MeditationAPI.shared.getAllMeditations()
                } else {
                    meditations = try await MeditationAPI.shared.searchMeditations(query: trimmed)
                }
            } catch {
                self.error = error
            }
        }
}


