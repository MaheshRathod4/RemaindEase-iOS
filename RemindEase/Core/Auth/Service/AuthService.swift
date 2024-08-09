//
//  AuthService.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    var currentUser: FirebaseAuth.User?
    static let shared = AuthService()

    init() {
        self.currentUser = Auth.auth().currentUser
        Task { try await UserService.shared.fetchCurrentUser() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.currentUser = result.user
            try await uploadUserData(email: email, name: name, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    private func uploadUserData(email: String, name: String, id: String) async throws {
        let user = UserModel()
        user.email = email
        user.name = name
        user.token = ""
        user.profileImage = ""
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.UserCollection.document(id).setData(encodedUser)
        UserService.shared.currentUser = user
    }
}
