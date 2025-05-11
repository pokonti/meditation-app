//
//  ModelAPI.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 09.05.2025.
//

import Foundation

struct SectionDTO: Codable {
    let id: Int
    let title: String
    let subtitle: String
    let duration: String
    let meditations: [MeditationDTO]?
}

struct MeditationDTO: Codable {
    let id: Int
    let title: String
    let duration_sec: Int
    let theme: String
    let drive_id: String
    let image_url: String?
    let section_id: Int?
}


enum APIError: Error {
    case invalidURL
    case invalidResponse(status: Int)
    case decodingError(Error)
}

