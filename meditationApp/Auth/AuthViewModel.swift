//
//  AuthViewModel.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//
import Foundation
import FirebaseAuth
//
//@MainActor
//final class AuthViewModel: ObservableObject {
//    @Published var isLoggedIn = false
//    @Published var userName = ""
//    @Published var errorMessage: String? = nil
//
//    private var handle: AuthStateDidChangeListenerHandle?
//
//    init() {
//        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            self?.isLoggedIn = (user != nil)
//            self?.userName   = user?.displayName ?? ""
//        }
//    }
//
//    deinit {
//        if let h = handle {
//            Auth.auth().removeStateDidChangeListener(h)
//        }
//    }
//    
//    var currentUserID: String? {
//        Auth.auth().currentUser?.uid
//    }
//
//    func register(name: String, email: String, password: String) async {
//        errorMessage = nil
//        do {
//            let result = try await Auth.auth()
//                .createUser(withEmail: email, password: password)
//            let changeReq = result.user.createProfileChangeRequest()
//            changeReq.displayName = name
//            try await changeReq.commitChanges()
//            // state listener will flip isLoggedIn → true
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//    }
//
//    /// Now this throws on failure instead of swallowing the error
//    func login(email: String, password: String) async throws {
//        // basic local validation
//        guard !email.isEmpty, !password.isEmpty else {
//            throw NSError(domain: "", code: 0,
//                userInfo: [NSLocalizedDescriptionKey: "Email and password cannot be empty"])
//        }
//        try await Auth.auth().signIn(withEmail: email, password: password)
//        // on success, state listener will set isLoggedIn = true
//    }
//
//    func logout() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//    }
//}


final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userName: String = ""
    @Published var currentUserID: String? = nil   // ← publish the UID
    @Published var errorMessage: String? = nil

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isLoggedIn      = (user != nil)
            self?.userName        = user?.displayName ?? ""
            self?.currentUserID   = user?.uid
        }
    }

    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }

    func register(name: String, email: String, password: String) async {
        errorMessage = nil
        do {
            let result = try await Auth.auth()
                .createUser(withEmail: email, password: password)
            let changeReq = result.user.createProfileChangeRequest()
            changeReq.displayName = name
            try await changeReq.commitChanges()
            // state listener will fill in currentUserID for us
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func login(email: String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(
              domain: "",
              code: 0,
              userInfo: [
                NSLocalizedDescriptionKey:
                  "Email and password cannot be empty"
              ]
            )
        }
        try await Auth.auth().signIn(withEmail: email, password: password)
        // on success, state listener sets currentUserID
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
