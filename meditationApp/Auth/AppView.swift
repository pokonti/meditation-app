//
//  AppView.swift
//  meditationApp
//
//  Created by Firuza on 08.05.2025.
//import SwiftUI
//
//struct AppView: View {
//    @EnvironmentObject var router: AppRouter
//    @StateObject private var authVM = AuthViewModel()
//
//    var body: some View {
//        Group {
//            switch router.current {
//            case .login:
//                LoginView(authVM: authVM)
//            case .register:
//                RegisterView(authVM: authVM)
//            case .home:
//                MeView(authVM: authVM)
//            }
//        }
//    }
//}
