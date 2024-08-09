//
//  AuthError.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import Foundation
import Firebase

enum CustomErrors {
    case userNameNotAvailable
}

enum AuthError: Error {
    case invalidEmail
    case invalidPassword
    case userNotFound
    case weakPassword
    case userNameNotAvailable
    case unknown
    
    init(authErrorCode: AuthErrorCode.Code) {
        switch authErrorCode {
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword:
            self = .invalidPassword
        case .weakPassword:
            self = .weakPassword
        case .userNotFound:
            self = .userNotFound
        default:
            self = .unknown
        }
    }
    
    init(customError: CustomErrors) {
        switch customError {
        case .userNameNotAvailable:
            self = .userNameNotAvailable
        default:
            self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .invalidEmail:
            return "The email you entered is invalid. Please try again"
        case .invalidPassword:
            return "Incorrect password. Please try again"
        case .userNotFound:
            return "It looks like there is no account associated with this email. Create an account to continue"
        case .weakPassword:
            return "Your password must be at least 6 characters in length. Please try again."
        case .unknown:
            return "An unknown error occurred. Please try again."
        case .userNameNotAvailable:
            return "The username is not available. Please choose a different username."
        }
    }
}
