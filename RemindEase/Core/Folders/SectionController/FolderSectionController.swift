//
//  FolderSectionController.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import IGListKit

class FolderSectionController : ListSectionController {
    
    var item: Folder?
    weak var folderClickDelegate:FolderClickDelegate?
    
    init(folderClickDelegate: FolderClickDelegate) {
        self.folderClickDelegate = folderClickDelegate
        super.init()
    }
     
     override func sizeForItem(at index: Int) -> CGSize {
         return CGSize(width: UIScreen.main.bounds.width, height: 100)
     }
     
     override func cellForItem(at index: Int) -> UICollectionViewCell {
         let cell = collectionContext.dequeueReusableCell(withNibName: "FolderCollectionViewCell", bundle: nil, for: self, at: index) as! FolderCollectionViewCell
         cell.lblName.text = item?.name
         return cell
     }
     
     override func didUpdate(to object: Any) {
         item = object as? Folder
     }
    
    override func didSelectItem(at index: Int) {
        if let item {
            folderClickDelegate?.didTapOnFolder(folder: item)
        }
    }
}
