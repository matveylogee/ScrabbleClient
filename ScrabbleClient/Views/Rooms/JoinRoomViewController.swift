//
//  JoinRoomViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class JoinRoomViewController: UIViewController {
    
    private let viewModel = RoomViewModel()
    
    private let inviteCodeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Invite Code"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join Room", for: .normal)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Join Room"
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(inviteCodeField)
        view.addSubview(joinButton)
        view.addSubview(statusLabel)
        
        inviteCodeField.translatesAutoresizingMaskIntoConstraints = false
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inviteCodeField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inviteCodeField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            inviteCodeField.widthAnchor.constraint(equalToConstant: 250),
            
            joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinButton.topAnchor.constraint(equalTo: inviteCodeField.bottomAnchor, constant: 20),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 20)
        ])
        
        joinButton.addTarget(self, action: #selector(joinRoomTapped), for: .touchUpInside)
    }
    
    @objc private func joinRoomTapped() {
        guard let code = inviteCodeField.text, !code.isEmpty else {
            statusLabel.text = "Please enter an invite code."
            return
        }
        
        viewModel.joinRoom(inviteCode: code) { success in
            DispatchQueue.main.async {
                self.statusLabel.text = success ? "Successfully joined the room." : "Failed to join the room."
            }
        }
    }
}

