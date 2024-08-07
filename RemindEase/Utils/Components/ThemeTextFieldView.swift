//
//  ThemeTextFieldView.swift
//  Harmonise
//
//  Created by MTPC-206 on 05/06/24.
//

import Foundation
import UIKit

class ThemeTextFieldView : UIView {
    
    @IBOutlet weak var containerViewTextField: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        guard let view = loadViewFromNib(nibName: "ThemeTextFieldView") else { return }
        containerViewTextField.layer.cornerRadius = 10
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
    }
    
}
