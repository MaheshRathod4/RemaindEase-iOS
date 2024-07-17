//
//  FolderService.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore

class FolderService {
    
    let realm = try! Realm()
    var lastDocumentSnapshot: DocumentSnapshot?
    
    func saveFolderToRealm(_ folder: Folder) {
        DispatchQueue.main.async { [weak self] in
            try! self?.realm.write { [weak self] in
                self?.realm.add(folder,update: .modified)
            }
        }
    }
    
    func fetchFolders(with limit: Int) async throws -> [OnlineFolder] {
        
        var query = FirestoreConstants
            .FolderCollection.order(by: "createAt").limit(to: limit)
        
        if let lastSnapshot = lastDocumentSnapshot {
            query = query.start(afterDocument: lastSnapshot)
        }
        
        let snapShot =  try await query.getDocuments()
        self.lastDocumentSnapshot = snapShot.documents.last
      
        let folders = snapShot.documents.compactMap({ try? $0.data(as: OnlineFolder.self) })
        return folders
    }
    
}
