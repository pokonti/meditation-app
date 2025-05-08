//
//  MeView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct MeView: View {
    @ObservedObject var authVM: AuthViewModel
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 24) {
            Text("Hello, \(authVM.userName)")
                .font(.title2).bold()

            Button("Log out") {
                authVM.logout()
                router.showLogin()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.red)
            .padding(.horizontal, 24)
        }
        .padding(.vertical, 40)
    }
}
