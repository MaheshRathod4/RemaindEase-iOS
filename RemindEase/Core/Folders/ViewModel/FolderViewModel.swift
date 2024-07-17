//
//  FolderViewModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import RealmSwift

class FolderViewModel {
    
    private let folderService = FolderService()
    var items: Results<Folder>?
    
    func fetchFolders(with limit: Int) async {
        let folders = try? await folderService.fetchFolders(with: limit)
        folders?.forEach { [weak self] onlineFolder in
            let folder = Folder()
            folder.name = onlineFolder.name
            folder.id = onlineFolder.id
            self?.folderService.saveFolderToRealm(folder)
        }
    }
    
}
