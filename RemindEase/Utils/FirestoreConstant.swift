//
//  FirestoreConstant.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import FirebaseFirestore

struct FirestoreConstants {
    private static let Root = Firestore.firestore()
//    private static let StorageRoot = Storage.storage().reference()
    static let UserCollection = Root.collection("users")
    static let FolderCollection = Root.collection("folders")
}
