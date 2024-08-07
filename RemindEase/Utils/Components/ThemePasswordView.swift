//
//  ThemePasswordView.swift
//  Harmonise
//
//  Created by MTPC-206 on 09/06/24.
//

import Foundation
import UIKit

class ThemePasswordView : UIView {
    
    @IBOutlet weak var btnPasswordToggle: UIButton!
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
        guard let view = loadViewFromNib(nibName: "ThemePasswordView") else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func onTapPasswordToggle(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        btnPasswordToggle.setImage(textField.isSecureTextEntry ? UIImage(resource: .eyeClose) : UIImage(resource: .eyeOpen), for: .normal)
    }
    
}
