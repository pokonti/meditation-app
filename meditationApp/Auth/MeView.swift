//
//  MeView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct MeView: View {
    @ObservedObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // — Фиолетовый прямоугольник с именем
                Text(authVM.userName.isEmpty ? "User" : authVM.userName)
                    .font(.title2).bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(Color.purple)
                    .cornerRadius(0)
                
                // — Список опций
                VStack(spacing: 1) {
                    // Notifications
                    NavigationLink(destination: /* Your Notifications screen */ Text("Notifications")) {
                        MeRow(icon: "bell", text: "Notifications", iconColor: .primary)
                    }
                    .buttonStyle(.plain)

                    // About
                    NavigationLink(destination: /* Your About screen */ Text("About")) {
                        MeRow(icon: "info.circle", text: "About", iconColor: .primary)
                    }
                    .buttonStyle(.plain)

                    // Log out
                    Button(action: {
                        authVM.logout()
                    }) {
                        MeRow(icon: "arrow.backward", text: "Log out", iconColor: .green)
                    }
                    .buttonStyle(.plain)
                }
                .background(Color.white)
                .cornerRadius(8)
                .padding(.top, 16)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

/// Вспомогательный рядок для пунктов меню
struct MeRow: View {
    let icon: String
    let text: String
    let iconColor: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 32)
            
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()

            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView(authVM: AuthViewModel())
    }
}
