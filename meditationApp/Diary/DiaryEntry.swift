//
//  DiaryEntry.swift
//  meditationApp
//
//  Created by Firuza on 06.05.2025.
//

import Foundation

struct DiaryEntry: Identifiable {
    let id      = UUID()
    let title   : String
    let content : String
    let date    : Date
    let mood    : Int
}
