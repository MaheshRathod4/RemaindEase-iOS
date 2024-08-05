//
//  Remainder.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import IGListKit

class Remainder: Object,ListDiffable,Codable {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var title = ""
    @Persisted var completedBy = List<CompletedUsers>()
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Remainder else { return false }
        return id == object.id &&
        title == object.title &&
        completedBy == object.completedBy
    }
}
