//
//  AuthViewModel.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//
import Foundation
import FirebaseAuth
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool
    @Published var errorMessage: String?
    @Published var userName: String = ""

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        let current = Auth.auth().currentUser
        self.isLoggedIn = (current != nil)
        self.userName = current?.displayName ?? ""

        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isLoggedIn = (user != nil)
            self?.userName = user?.displayName ?? ""
        }
    }

    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }

    func register(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }
            guard let user = result?.user else { return }

            // устанавливаем displayName
            let changeReq = user.createProfileChangeRequest()
            changeReq.displayName = name
            changeReq.commitChanges { [weak self] err in
                if let err = err {
                    DispatchQueue.main.async {
                        self?.errorMessage = err.localizedDescription
                    }
                } else {
                    // сразу обновляем Published-свойство
                    DispatchQueue.main.async {
                        self?.userName = name
                    }
                }
            }
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            } else {
                // при входе listener подтянет displayName
                print("✅ Залогинен:", result?.user.uid ?? "")
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.userName = ""
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
