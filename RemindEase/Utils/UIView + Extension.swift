//
//  UIView + Extension.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import UIKit

import Foundation
import UIKit

@IBDesignable
class CustomizeView:UIView {
    
    @IBInspectable
    var borderColor:UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth:CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var shadowColor:UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset:CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable
    var shadowRadius:CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable
    var shadowOpacity:Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var topLeftCornerRadius:Bool = true {
        didSet {
            setCustomCornerRadius()
        }
    }
    @IBInspectable var topRightCornerRadius:Bool = true {
        didSet {
            setCustomCornerRadius()
        }
    }
    @IBInspectable var bottomLeftCornerRadius:Bool = true {
        didSet {
            setCustomCornerRadius()
        }
    }
    @IBInspectable var bottomRightCornerRadius:Bool = true {
        didSet {
            setCustomCornerRadius()
        }
    }
    private func setCustomCornerRadius() {
        var cornerMask = CACornerMask()
        if topLeftCornerRadius {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if topRightCornerRadius {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if bottomLeftCornerRadius {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if bottomRightCornerRadius {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        layer.maskedCorners = cornerMask
    }
}

extension UIView {
    func loadViewFromNib(nibName:String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
