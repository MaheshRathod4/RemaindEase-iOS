//
//  Folder.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import IGListKit

class Folder: Object,ListDiffable,Codable {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var name = ""
    @Persisted var ownerID = ""
    @Persisted var createAt:Date?
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Folder else { return false }
        return id == object.id && name == object.name
    }
    
    required override init() {
        super.init()
    }
    
    required init(dic:[String:Any]) {
        self.name = dic["name"] as? String ?? ""
        self.id = dic["id"] as? String ?? ""
        self.ownerID = dic["id"] as? String ?? ""
        let timestamp = dic["createAt"] as? Timestamp
        self.createAt = timestamp?.dateValue()
    }
}
