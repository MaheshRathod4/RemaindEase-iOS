//
//  AuthViewModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import Foundation
import Combine
import FirebaseAuth

class LoginViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isFormValid: Bool = false
    @Published var isAuthenticating = false
    @Published var authError: AuthError?
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        Publishers.CombineLatest($email, $password)
            .map { [weak self] email, password in
                return self?.validForm(email: email, password: password) ?? false
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    
    @MainActor
    func login() async throws {
        isAuthenticating = true
        do {
            try await AuthService.shared.login(withEmail: email, password: password)
            isAuthenticating = false
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            isAuthenticating = false
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
        }
    }
    
    func validForm(email: String, password: String) -> Bool {
        return !email.isEmpty
        && email.contains("@")
        && (password.count > 5)
    }
}
