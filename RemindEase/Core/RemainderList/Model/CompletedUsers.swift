//
//  CompletedUsers.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import IGListKit

class CompletedUsers: Object,ListDiffable,Codable {
    
    @Persisted(primaryKey: true) var id = ""
    @Persisted var userId = ""
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? CompletedUsers else { return false }
        return id == object.id && userId == object.userId
    }
}



