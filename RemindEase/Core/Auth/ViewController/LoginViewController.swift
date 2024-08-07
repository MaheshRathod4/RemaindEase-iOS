//
//  LoginViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 06/08/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var themePasswordTextFieldView: ThemePasswordView!
    @IBOutlet weak var themeEmailTextFieldView: ThemeTextFieldView!
    
    var loader:LoaderViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        loader = LoaderViewController()
        setupUI()
    }
    
    func setupUI() {
        
    }
    
}

extension LoginViewController {
    
    @IBAction func didTapOnSignIn(_ sender: Any) {
       
    }
    
    @IBAction func didTapOnSignUp(_ sender: Any) {
        
    }
    
    @IBAction func didTapOnForgotPassword(_ sender: Any) {
        
    }
}
