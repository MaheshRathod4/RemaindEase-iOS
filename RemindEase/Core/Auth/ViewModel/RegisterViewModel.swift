//
//  RegisterViewModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import Foundation
import Combine
import FirebaseAuth

class RegisterViewModel {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isFormValid: Bool = false
    @Published var isAuthenticating = false
    @Published var authError: AuthError?
    
    private var cancellable = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest4($name, $email, $password, $confirmPassword)
            .map { [weak self] name,email, password,confirmPassword in
                return self?.validForm(name: name, email: email, password: password, confirmPassword: confirmPassword) ?? false
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    func validForm(name: String,email: String, password: String,confirmPassword: String) -> Bool {
        return !email.isEmpty
        && !name.isEmpty
        && email.contains("@")
        && (password.count > 5)
        && (confirmPassword.count > 5)
        && password != confirmPassword
    }
    
    @MainActor
    func registerUser() async throws {
        do {
            try await AuthService.shared.createUser(withEmail: email, password: password, name: name)
            isAuthenticating = false
        } catch {
            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
            isAuthenticating = false
            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
        }
    }
    
}
