//
//  UserModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import IGListKit

class UserModel: Object,ListDiffable,Codable {
    
    @Persisted(primaryKey: true) var id = ""
    @Persisted var email = ""
    @Persisted var name = ""
    @Persisted var token = ""
    @Persisted var profileImage = ""
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? UserModel else { return false }
        return id == object.id &&
        email == object.email
    }
    
    
}
