//
//  LoginViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 06/08/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var themePasswordTextFieldView: ThemePasswordView!
    @IBOutlet weak var themeEmailTextFieldView: ThemeTextFieldView!
    
    private let viewModel = AuthViewModel()
    var loader = LoaderViewController()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        themeEmailTextFieldView.lblTitle.text = "Email address"
        themeEmailTextFieldView.textField.keyboardType = .emailAddress
        themeEmailTextFieldView.textField.placeholder = "Email address"
        themePasswordTextFieldView.textField.returnKeyType = .done
    }
    
    func setupBindings() {
        viewModel.$email
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.themeEmailTextFieldView.textField.text = $0 }
            .store(in: &cancellable)
        
        viewModel.$password
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.themePasswordTextFieldView.textField.text = $0 }
            .store(in: &cancellable)
        
        viewModel.$isFormValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isFormValid in
                self?.btnLogin.isEnabled = isFormValid
                self?.btnLogin.alpha = isFormValid ? 1.0 : 0.6
            }
            .store(in: &cancellable)
        
        viewModel.$isAuthenticating.sink { [weak self] isAuthenticating in
            guard let self else { return }
            if isAuthenticating {
                present(loader, animated: true)
            } else {
                loader.dismiss(animated: true)
            }
        }.store(in: &cancellable)
        
        viewModel.$authError.sink { [weak self] authError in
            guard let self else { return }
            print(authError)
        }.store(in: &cancellable)
        
        themeEmailTextFieldView.textField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        themePasswordTextFieldView.textField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
    }
    
    @objc private func emailTextFieldChanged() {
        viewModel.email = themeEmailTextFieldView.textField.text ?? ""
    }
    
    @objc private func passwordTextFieldChanged() {
        viewModel.password = themePasswordTextFieldView.textField.text ?? ""
    }
    
}

extension LoginViewController {
    
    @IBAction func didTapOnSignIn(_ sender: Any) {
        Task { try await viewModel.login() }
    }
    
    @IBAction func didTapOnSignUp(_ sender: Any) {
        
    }
    
    @IBAction func didTapOnForgotPassword(_ sender: Any) {
        
    }
}
