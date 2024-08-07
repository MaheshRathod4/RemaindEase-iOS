//
//  Storybords.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import UIKit

enum Storyboards : String {
   case Folder
   case RemainderList
   case Main
   case Auth
   case Loader
}

extension Storyboards {
    func viewController(_ viewController : UIViewController.Type) -> some UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: viewController.self))
    }
}
