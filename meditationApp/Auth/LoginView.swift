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

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.60, green: 0.15, blue: 0.85),
                    Color(red: 0.75, green: 0.40, blue: 0.90)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Welcome Back")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button {
                        Task {
                            await authVM.login(email: email, password: password)
                            if authVM.isLoggedIn {
                                router.showMain()
                            }
                        }
                    } label: {
                        Text("Log In")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal, 24)

                Button("Нет аккаунта? Зарегистрироваться") {
                    router.showRegister()
                }
                .font(.footnote)
                .foregroundColor(.white)
            }
            .padding(.vertical, 40)
        }
    }
}
