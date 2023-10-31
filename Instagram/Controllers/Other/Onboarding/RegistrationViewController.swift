//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    private let usernameField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Username"
        emailField.returnKeyType = .next
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.leftViewMode = .always
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.layer.cornerRadius = 8
        emailField.layer.borderWidth = 1.0
        emailField.layer.borderColor = UIColor.secondaryLabel.cgColor
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.masksToBounds = true
        
        return emailField
    }()
    
    private let emailField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email Adress"
        email.returnKeyType = .next
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        email.leftViewMode = .always
        email.autocapitalizationType = .none
        email.autocorrectionType = .no
        email.layer.cornerRadius = 8
        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.secondaryLabel.cgColor
        email.backgroundColor = .secondarySystemBackground
        email.layer.masksToBounds = true
        
        return email
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        
        return field
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setButtonTargets()
        view.addSubviews(usernameField, passwordField, emailField, registrationButton)
        setFieldsDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 30, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 20, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 20, width: view.width - 40, height: 52)
        registrationButton.frame = CGRect(x: 20, y: passwordField.bottom + 30, width: view.width - 40, height: 52)
    }
    
    //MARK: - Private
    
    private func setButtonTargets() {
        registrationButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    private func setFieldsDelegate() {
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @objc private func didTapRegisterButton() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let username = usernameField.text, !username.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) {
            [weak self] registered in
            DispatchQueue.main.async {
                if registered {
                    
                } else {
                    
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        
        return true
    }
}
