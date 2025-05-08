//
//  ViewModel.swift
//  meditationApp
//
//  Created by Aknur Seidazym on 05.05.2025.
//
import SwiftUI

class ViewModel: ObservableObject {
    @Published var courses: [MeditationCourse] = []
    @Published var selectedCourse: MeditationCourse?
    
    init() {
        loadCourses()
    }
    
    func loadCourses() {
        // Mock data
        let meditations = [
            Meditation(id: "1", title: "Focus Attention", duration: "10 MIN", audioURL: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3"),
            Meditation(id: "2", title: "Body Scan", duration: "5 MIN", audioURL: "https://mprdtlzujmldbvhl.public.blob.vercel-storage.com/2_meditation-MXEJB1HJGJ1xl4Kzqsjf66UsCakATC.mp3"),
            Meditation(id: "3", title: "Making Happiness", duration: "3 MIN", audioURL: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")
        ]
        
        courses = [
            MeditationCourse(id: "basics", title: "Basics", subtitle: "COURSE", duration: "3-10 MIN",  image: Image("basics2"),  meditations: meditations),
            MeditationCourse(id: "relaxation", title: "Relaxation", subtitle: "MUSIC", duration: "3-10 MIN",  image: Image("just"),     meditations: meditations),
            MeditationCourse(id: "daily", title: "Daily Thought", subtitle: "MEDITATION", duration: "3-10 MIN",  image: Image("daily"),     meditations: meditations),
            MeditationCourse(id: "morning", title: "Happy Morning", subtitle: "COURSE", duration: "10-15 MIN",  image: Image("daily"),     meditations: meditations),
            MeditationCourse(id: "focus", title: "Focus", subtitle: "MEDITATION", duration: "3-10 MIN",  image: Image("basics"),     meditations: meditations),
            MeditationCourse(id: "happiness", title: "Happiness", subtitle: "MEDITATION", duration: "3-10 MIN",  image: Image("basics"),     meditations: meditations)
        ]
    }
    
    func selectCourse(_ course: MeditationCourse) {
        selectedCourse = course
    }
}
