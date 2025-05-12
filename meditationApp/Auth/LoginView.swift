//
//  LoginView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    @EnvironmentObject var router: AppRouter

    @State private var email = ""
    @State private var password = ""

    // MARK: — Цветовая палитра
    private let bgGradientStart = Color(red: 0.95, green: 0.97, blue: 1.0)
    private let bgGradientEnd   = Color(red: 0.85, green: 0.76, blue: 0.98)
    private let accentViolet    = Color(red: 0.65, green: 0.49, blue: 0.98)

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [bgGradientStart, bgGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                // Logo + app name
                HStack(spacing: 8) {
                    Text("Tynys")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(accentViolet)
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("Ber")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(accentViolet)
                }
                .padding(.horizontal, 24)

                VStack(spacing: 16) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(accentViolet)

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button {
                        Task {
                            authVM.errorMessage = nil
                            do {
                                try await authVM.login(email: email, password: password)
                                router.showMain()
                            } catch {
                                authVM.errorMessage = error.localizedDescription
                            }
                        }
                    } label: {
                        Text("Log In")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(accentViolet)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button("Don't have an account? Sign up") {
                        router.showRegister()
                    }
                    .font(.footnote)
                    .foregroundColor(accentViolet.opacity(0.8))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 40)
        }
        .onChange(of: authVM.isLoggedIn) { loggedIn in
            if loggedIn {
                router.showMain()
            }
        }
    }
}
