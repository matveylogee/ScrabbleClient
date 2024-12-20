//
//  RegisterViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import UIKit

class AccountDeletionViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private let usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Account", for: .normal)
        button.tintColor = .red
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
        view.addSubview(deleteButton)
        view.addSubview(statusLabel)
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            usernameField.widthAnchor.constraint(equalToConstant: 250),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20),
            statusLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        deleteButton.addTarget(self, action: #selector(deleteAccountTapped), for: .touchUpInside)
    }
    
    @objc private func deleteAccountTapped() {
        guard let username = usernameField.text, (username).isEmpty else {
            statusLabel.text = "Please enter your username."
            return
        }
        
        viewModel.deleteAccount(username: username) { success in
            DispatchQueue.main.async {
                if success {
                    self.statusLabel.text = "Account deleted successfully."
                } else {
                    self.statusLabel.text = "Failed to delete account. Try again."
                }
            }
        }
    }
}

