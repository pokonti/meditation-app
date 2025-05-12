//
//  SearchViewModel.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 08.05.2025.
//
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var meditations: [Meditation] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var query: String = ""

    func search() async {
        await MainActor.run {
            isLoading = true
            error = nil
        }

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            let result: [Meditation]
            if trimmed.isEmpty {
                result = try await MeditationAPI.shared.getAllMeditations()
            } else {
                result = try await MeditationAPI.shared.searchMeditations(query: trimmed)
            }

            await MainActor.run {
                self.meditations = result
            }

        } catch {
            await MainActor.run {
                self.error = error
            }
        }

        await MainActor.run {
            isLoading = false
        }
    }
}

