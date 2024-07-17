//
//  LoadingSectionController.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import Foundation
import IGListKit

class LoadingIndicator: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "loadingIndicator" as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

class LoadingSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 44)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: LoadingIndicatorCell.self, for: self, at: index)
        return cell
    }
    
    override func didUpdate(to object: Any) {}
}
