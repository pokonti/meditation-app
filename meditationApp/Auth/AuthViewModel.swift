//
//  AuthViewModel.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//
import Foundation
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userName: String = ""
    @Published var errorMessage: String?

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isLoggedIn = (user != nil)
            self?.userName   = user?.displayName ?? ""
        }
    }

    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }

    func register(name: String, email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let changeReq = result.user.createProfileChangeRequest()
            changeReq.displayName = name
            try await changeReq.commitChanges()
            // AuthState listener автоматически обновит isLoggedIn и userName
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func login(email: String, password: String) async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            // AuthState listener обновит isLoggedIn
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            // AuthState listener сбросит isLoggedIn и userName
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
