//
//  FavouritesAPI.swift
//  meditationApp
//
//  Created by Амангелди Мадина on 11.05.2025.
//

import Foundation

enum FavoritesAPIError: Error {
  case invalidURL, invalidResponse(status: Int), decodingError(Error)
}

struct FavoritesAPI {
  static let shared = FavoritesAPI()
  private let base = "https://laudable-liberation-production-53fd.up.railway.app"

  /// Fetch the list of favorite meditation IDs for this user
  func getFavorites(userID: String) async throws -> [String] {
    guard let url = URL(string: "\(base)/favorites/\(userID)") else {
      throw FavoritesAPIError.invalidURL
    }
    let (data, resp) = try await URLSession.shared.data(from: url)
    guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw FavoritesAPIError.invalidResponse(status: (resp as? HTTPURLResponse)?.statusCode ?? -1)
    }
    do {
      return try JSONDecoder().decode([String].self, from: data)
    } catch {
      throw FavoritesAPIError.decodingError(error)
    }
  }

  /// Add a meditation to favorites
  @discardableResult
  func addFavorite(userID: String, meditationID: String) async throws -> String {
    guard let url = URL(string: "\(base)/favorites/\(userID)/\(meditationID)") else {
      throw FavoritesAPIError.invalidURL
    }
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    let (data, resp) = try await URLSession.shared.data(for: req)
    guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw FavoritesAPIError.invalidResponse(status: (resp as? HTTPURLResponse)?.statusCode ?? -1)
    }
    return try JSONDecoder().decode(String.self, from: data)
  }

  /// Remove a meditation from favorites
  @discardableResult
  func removeFavorite(userID: String, meditationID: String) async throws -> String {
    guard let url = URL(string: "\(base)/favorites/\(userID)/\(meditationID)") else {
      throw FavoritesAPIError.invalidURL
    }
    var req = URLRequest(url: url)
    req.httpMethod = "DELETE"
    let (data, resp) = try await URLSession.shared.data(for: req)
    guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw FavoritesAPIError.invalidResponse(status: (resp as? HTTPURLResponse)?.statusCode ?? -1)
    }
    return try JSONDecoder().decode(String.self, from: data)
  }
}
