//
//  RegisterView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct RegisterHeaderView: View {
    private let logoImageName = "Logo"

    var body: some View {
        HStack(spacing: 8) {
            Text("Tynys")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)

            Image(logoImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 32)

            Text("Ber")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
        .padding(.top, 32)
    }
}

struct RegisterView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var name     = ""
    @State private var email    = ""
    @State private var password = ""
    @Environment(\.presentationMode) private var presentationMode

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

            VStack(spacing: 24) {
                RegisterHeaderView()

                Spacer(minLength: 0)
                VStack(spacing: 16) {
                    Text("Register")
                        .font(.largeTitle).bold()
                        .foregroundColor(accentViolet)

                    Group {
                        TextField("Your Name", text: $name)
                            .autocapitalization(.words)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    authVM.errorMessage = nil
                                }
                            }
                    }

                    Button(action: {
                        authVM.register(name: name, email: email, password: password)
                    }) {
                        Text("Create Account")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(accentViolet)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Button("Уже есть аккаунт? Войти") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.footnote)
                    .foregroundColor(accentViolet)
                    .padding(.top, 4)
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding(.horizontal, 16)

                Spacer(minLength: 0)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authVM: AuthViewModel())
    }
}
