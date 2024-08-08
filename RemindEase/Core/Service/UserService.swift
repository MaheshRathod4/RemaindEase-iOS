//
//  UserService.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import Foundation
import Firebase

class UserService {
    
    var currentUser: UserModel?
    
    static let shared = UserService()
    private static let userCache = NSCache<NSString, NSData>()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await FirestoreConstants.UserCollection.document(uid).getDocument()
        let user = try snapshot.data(as: UserModel.self)
        self.currentUser = user
    }
}
