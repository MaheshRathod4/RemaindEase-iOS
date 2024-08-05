//
//  CurrentRemainderSectionController.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import IGListKit

class CurrentRemainderSectionController : ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext.dequeueReusableCell(withNibName: "RemainderCollectionViewCell", bundle: nil, for: self, at: index) as! RemainderCollectionViewCell
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
       
    }
    
}
