//
//  LoginViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel = AuthViewModel()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.text = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register?", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            emailField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("Missing fields")
            return
        }
        
        viewModel.login(email: email, password: password) {
            DispatchQueue.main.async {
                if let authResponse = self.viewModel.authResponse {
                
                    print("Welcome, \(authResponse.user.id)")
                    
                    APIClient.shared.bearerToken = authResponse.value
                    
                    self.navigationController?.pushViewController(GameStartViewController(), animated: true)
                    
                } else if let error = self.viewModel.error {
                    print("Error: \(error)")
                    
//                    self.navigationController?.pushViewController(GameStartViewController(), animated: true)
                }
            }
        }
    }
    
    @objc private func registerTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
