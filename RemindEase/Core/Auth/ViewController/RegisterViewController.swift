//
//  RegisterViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var themeTextFieldPassword: ThemePasswordView!
    @IBOutlet weak var themeTextFieldEmail: ThemeTextFieldView!
    @IBOutlet weak var themeTextFieldName: ThemeTextFieldView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var ThemeTextFieldConfimPassword: ThemePasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        themeTextFieldName.lblTitle.text = "Name"
        themeTextFieldName.textField.placeholder = "Enter Name"
        themeTextFieldEmail.lblTitle.text = "Email"
        themeTextFieldEmail.textField.placeholder = "Enter Email"
        themeTextFieldPassword.lblTitle.text = "Password"
        themeTextFieldPassword.textField.placeholder = "EnterPassword"
        ThemeTextFieldConfimPassword.lblTitle.text = "Confirm Password"
        ThemeTextFieldConfimPassword.textField.placeholder = "Enter Confirm Password"
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBack))
        imgBack.isUserInteractionEnabled = true
        imgBack.addGestureRecognizer(tap)
    }

}

extension RegisterViewController {
    
    @IBAction func didTapRegister(_ sender: Any) {
        
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnBack() {
        self.navigationController?.popViewController(animated: true)

    }
}
