//
//  RegisterViewModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import Foundation
import Combine
import FirebaseAuth
import PhoneNumberKit

class RegisterViewModel {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var confirmPassword: String = ""
    @Published var isFormValid: Bool = false
    @Published var isAuthenticating = false
    @Published var authError: AuthError?
    
    var phoneNumberKit:PhoneNumberKit?
    
    private var cancellable = Set<AnyCancellable>()

    init() {
        phoneNumberKit = PhoneNumberKit()
        Publishers.CombineLatest($name,$email)
            .combineLatest($password, $confirmPassword)
            .combineLatest($phoneNumber)
            .map { [weak self] combined, phoneNumber in
                let (name,email) = combined.0
                let password = combined.1
                let confirmPassword = combined.2
                return self?.validForm(name: name, email: email, password: password, phoneNumber: phoneNumber, confirmPassword: confirmPassword) ?? false
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    func validForm(name: String,email: String, password: String,phoneNumber: String,confirmPassword: String) -> Bool {
        let fourFieldResult = !email.isEmpty
        && !name.isEmpty
        && email.contains("@")
        && (password.count > 5)
        && (confirmPassword.count > 5)
        && password == confirmPassword
        do {
            let phoneNumber = try phoneNumberKit?.parse(phoneNumber)
            return fourFieldResult && true
        }
        catch {
            print("Generic parser error")
            return fourFieldResult && false
        }
    }
    
    @MainActor
    func registerUser() async throws -> Bool {
        isAuthenticating = true
        do {
            try await AuthService.shared.createUser(withEmail: email, password: password, name: name, phoneNumber: phoneNumber)
            isAuthenticating = false
            return true
        } catch {
            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
            isAuthenticating = false
            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
            return false
        }
    }
    
}
