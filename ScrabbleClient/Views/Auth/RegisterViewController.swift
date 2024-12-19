//
//  RegisterViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private let usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(statusLabel)
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            usernameField.widthAnchor.constraint(equalToConstant: 250),
            
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 250),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            statusLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc private func registerTapped() {
        guard let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            statusLabel.text = "Please fill in all fields."
            return
        }
        
        viewModel.register(username: username, password: password) {
            DispatchQueue.main.async {
                if let user = self.viewModel.user {
                    self.statusLabel.text = "Welcome, \(user.username)! Registration successful."
                    
                    self.navigationController?.popViewController(animated: true)
                } else if let error = self.viewModel.error {
                    self.statusLabel.text = "Error: \(error)"
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}

