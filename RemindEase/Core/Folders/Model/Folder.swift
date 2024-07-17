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

class Folder: Object,ListDiffable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var ownerID = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Folder else { return false }
        return id == object.id && name == object.name
    }
}


class OnlineFolder: Codable {

    @DocumentID private var folderID: String?
    var name: String = ""
    var ownerID: String = ""
    
    var id: String {
        return folderID ?? UUID().uuidString
    }
    
    var dictionary: [String: Any] {
        return ["name": name, "ownerID": ownerID]
    }
}
