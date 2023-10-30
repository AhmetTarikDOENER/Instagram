//
//  LoginViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8
        static let gradient: String = "InstagramGradient"
        static let instagramTextLogo: UIImage = UIImage(named: "instagramTxtLogo")!
    }
    
    private let usernameEmailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Username or Email..."
        emailField.returnKeyType = .next
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.leftViewMode = .always
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.layer.cornerRadius = Constants.cornerRadius
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.masksToBounds = true
        
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New Here? Create an Account", for: .normal)
        
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: Constants.gradient))
        header.addSubview(backgroundImageView)
        
        return header
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(usernameEmailField, passwordField, loginButton, createAccountButton, termsButton, privacyButton, headerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height / 3.0)
        configureHeaderView()
    }
    
    //MARK: - Private
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        
        // Add instagram logo
        let imageView = UIImageView(image: Constants.instagramTextLogo)
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4, y: view.safeAreaInsets.top, width: headerView.width / 2.0, height: headerView.height - view.safeAreaInsets.top)
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 50, width: view.width - 50, height: 52)
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.width - 50, height: 52)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50, height: 52)
    }
    
    @objc private func didTapLoginButton() {
        
    }
    
    @objc private func didTapTermsButton() {
        
    }
    
    @objc private func didTapPrivacyButton() {
        
    }
    
    @objc private func didTapCreateAccountButton() {
        
    }
    
}
