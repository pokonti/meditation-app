//
//  MeditationAPI.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 09.05.2025.
//
import Foundation
import SwiftUI


final class MeditationAPI {
    static let shared = MeditationAPI()
    private init() { }
    
    private let baseURL = "https://laudable-liberation-production-53fd.up.railway.app"
    

    private let assetLookup: [Int: String] = [
        1: "daily",
        2: "just",
        3: "daily",
        4: "just"
    ]
    
    func fetchSections() async throws -> [MeditationCourse] {
        guard let url = URL(string: "\(baseURL)/sections") else {
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw APIError.invalidResponse(status: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let dtos = try JSONDecoder().decode([SectionDTO].self, from: data)
            return dtos.map { dto in
                MeditationCourse(
                    id: String(dto.id),
                    title: dto.title,
                    subtitle: dto.subtitle,
                    duration: dto.duration,
                    image: Image(assetLookup[dto.id] ?? "DefaultCourseImage"),
                    meditations: dto.meditations?.map { meditationDTO in
                        return Meditation(
                            id: String(meditationDTO.id),
                            title: meditationDTO.title,
                            duration: TimeInterval(meditationDTO.duration_sec),
                            theme: meditationDTO.theme,
                            audioURL: meditationDTO.drive_id,
                            imageURL: meditationDTO.image_url
                        )
                    } ?? []
                )
            }
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    
    func getAllMeditations() async throws -> [Meditation] {
        guard let url = URL(string: "\(baseURL)/meditations/") else {
            throw APIError.invalidURL
        }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard
          let http = resp as? HTTPURLResponse,
          (200...299).contains(http.statusCode)
        else {
          throw APIError.invalidResponse(status: (resp as? HTTPURLResponse)?.statusCode ?? -1)
        }
        let dtos = try JSONDecoder().decode([MeditationDTO].self, from: data)
        return dtos.map { dto in
          Meditation(
            id: String(dto.id),
            title: dto.title,
            duration: TimeInterval(dto.duration_sec),
            theme: dto.theme,
            audioURL: dto.drive_id,
            imageURL: dto.image_url
          )
        }
    }


          
    func searchMeditations(query: String) async throws -> [Meditation] {
       let q = query.addingPercentEncoding(
         withAllowedCharacters: .urlQueryAllowed
       ) ?? ""
       guard let url = URL(string: "\(baseURL)/meditations/search?query=\(q)") else {
           throw APIError.invalidURL
       }
       let (data, resp) = try await URLSession.shared.data(from: url)
       guard let http = resp as? HTTPURLResponse,
             (200...299).contains(http.statusCode) else {
           throw APIError.invalidResponse(
             status: (resp as? HTTPURLResponse)?.statusCode ?? -1
           )
       }
       do {
           let dtos = try JSONDecoder().decode([MeditationDTO].self, from: data)
           return dtos.map {
               Meditation(
                 id: String($0.id),
                 title: $0.title,
                 duration: TimeInterval($0.duration_sec),
                 theme: $0.theme,
                 audioURL: $0.drive_id,
                 imageURL: $0.image_url
               )
           }
       } catch {
           throw APIError.decodingError(error)
       }
   }
    
    func getMeditation(meditationID: Int) async throws -> Meditation {
        guard let url = URL(string: "\(baseURL)/meditations/\(meditationID)") else {
            throw APIError.invalidURL
        }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse,
              (200...299).contains(http.statusCode)
        else {
            throw APIError.invalidResponse(
              status: (resp as? HTTPURLResponse)?.statusCode ?? -1
            )
        }
        let dto = try JSONDecoder().decode(MeditationDTO.self, from: data)
        return Meditation(
          id: String(dto.id),
          title: dto.title,
          duration: TimeInterval(dto.duration_sec),
          theme: dto.theme,
          audioURL: dto.drive_id,
          imageURL: dto.image_url
        )
    }
}
