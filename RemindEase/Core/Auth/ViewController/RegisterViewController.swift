//
//  RegisterViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import UIKit
import PhoneNumberKit
import Combine

class RegisterViewController: UIViewController {

    @IBOutlet weak var btnSignUp:UIButton!
    @IBOutlet weak var textFieldPhoneNumber: PhoneNumberTextField!
    @IBOutlet weak var themeTextFieldPassword: ThemePasswordView!
    @IBOutlet weak var themeTextFieldEmail: ThemeTextFieldView!
    @IBOutlet weak var themeTextFieldName: ThemeTextFieldView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var ThemeTextFieldConfimPassword: ThemePasswordView!
    
    private let viewModel = RegisterViewModel()
    private var cancellable = Set<AnyCancellable>()
    var loader = LoaderViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObserver()
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
        PhoneNumberKit.CountryCodePicker.alwaysShowsSearchBar = true
        textFieldPhoneNumber.withFlag = true
        textFieldPhoneNumber.withExamplePlaceholder = true
        textFieldPhoneNumber.withDefaultPickerUI = true
        let options = CountryCodePickerOptions(
            backgroundColor: .background,
            separatorColor: UIColor.opaqueSeparator,
            textLabelColor: UIColor.title,
            textLabelFont: .preferredFont(forTextStyle: .callout),
            detailTextLabelColor: UIColor.secondaryLabel,
            detailTextLabelFont: .preferredFont(forTextStyle: .body),
            tintColor: .pink,
            cellBackgroundColor: .item,
            cellBackgroundColorSelection: UIColor.tertiarySystemGroupedBackground
        )
        textFieldPhoneNumber.withDefaultPickerUIOptions = options
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBack))
        imgBack.isUserInteractionEnabled = true
        imgBack.addGestureRecognizer(tap)
    }
    
    func setupObserver() {
        viewModel.$email
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.themeTextFieldEmail.textField.text = $0 }
            .store(in: &cancellable)
        
        viewModel.$password
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.themeTextFieldPassword.textField.text = $0 }
            .store(in: &cancellable)
        
        viewModel.$phoneNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.textFieldPhoneNumber.text = $0 }
            .store(in: &cancellable)
        
        viewModel.$isFormValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isFormValid in
                self?.btnSignUp.isUserInteractionEnabled = isFormValid
                self?.btnSignUp.alpha = isFormValid ? 1.0 : 0.6
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
            guard let self,let authError else { return }
            showAlertSafely(title: "Alert", message: authError.description)
        }.store(in: &cancellable)
        
        textFieldPhoneNumber.addTarget(self, action: #selector(phoneNumberTextFieldChanged), for: .editingChanged)
        themeTextFieldName.textField.addTarget(self, action: #selector(nameTextFieldChanged), for: .editingChanged)
        themeTextFieldEmail.textField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        ThemeTextFieldConfimPassword.textField.addTarget(self, action: #selector(confirmPasswordTextFieldChanged), for: .editingChanged)
        themeTextFieldPassword.textField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
    }
    
    @objc private func emailTextFieldChanged() {
        viewModel.email = themeTextFieldEmail.textField.text ?? ""
    }
    
    @objc private func passwordTextFieldChanged() {
        viewModel.password = themeTextFieldPassword.textField.text ?? ""
    }
    
    @objc private func nameTextFieldChanged() {
        viewModel.name = themeTextFieldName.textField.text ?? ""
    }
    
    @objc private func phoneNumberTextFieldChanged() {
        viewModel.phoneNumber = textFieldPhoneNumber.text ?? ""
    }
    
    @objc private func confirmPasswordTextFieldChanged() {
        viewModel.confirmPassword = ThemeTextFieldConfimPassword.textField.text ?? ""
    }

}

extension RegisterViewController {
    
    @IBAction func didTapRegister(_ sender: Any) {
        Task {
            let result = try await viewModel.registerUser()
            if result {
                
            }
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnBack() {
        self.navigationController?.popViewController(animated: true)

    }
}
