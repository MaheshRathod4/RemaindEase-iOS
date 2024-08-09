//
//  UIViewController + Extension.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertSafely(title: String, message: String, okButtonTitle: String = "OK", cancelButtonTitle: String? = nil, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
           guard self.presentedViewController == nil else {
               // A presentation is in progress, you may choose to delay the alert or ignore
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   self.showAlertSafely(title: title, message: message, okButtonTitle: okButtonTitle, cancelButtonTitle: cancelButtonTitle, okAction: okAction, cancelAction: cancelAction)
               }
               return
           }
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okButton = UIAlertAction(title: okButtonTitle, style: .default) { _ in
               okAction?()
           }
           alertController.addAction(okButton)
           
           if let cancelButtonTitle = cancelButtonTitle {
               let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
                   cancelAction?()
               }
               alertController.addAction(cancelButton)
           }
           
           self.present(alertController, animated: true, completion: nil)
       }
    
}
