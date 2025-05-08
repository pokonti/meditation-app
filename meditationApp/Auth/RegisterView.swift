//
//  RegisterView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var authVM: AuthViewModel
    @EnvironmentObject var router: AppRouter

    @State private var name = ""
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
                Text("Create Account")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)

                VStack(spacing: 16) {
                    TextField("Your Name", text: $name)
                        .autocapitalization(.words)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

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
                            await authVM.register(name: name, email: email, password: password)
                            if authVM.isLoggedIn {
                                router.showMain()
                            }
                        }
                    } label: {
                        Text("Create Account")
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

                Button("Уже есть аккаунт? Войти") {
                    router.showLogin()
                }
                .font(.footnote)
                .foregroundColor(.white)
            }
            .padding(.vertical, 40)
        }
    }
}
