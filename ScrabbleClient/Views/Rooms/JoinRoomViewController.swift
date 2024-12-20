//
//  JoinRoomViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class JoinRoomViewController: UIViewController {
    
    private let viewModel: RoomViewModel
        
    init(viewModel: RoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let inviteCodeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Invite Code"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let joinButton = CustomButton()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
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
            inviteCodeField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            inviteCodeField.widthAnchor.constraint(equalToConstant: 250),
            
            joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinButton.topAnchor.constraint(equalTo: inviteCodeField.bottomAnchor, constant: 20),
            joinButton.widthAnchor.constraint(equalToConstant: 200),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 20),
            statusLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        joinButton.setTitle("Join Room")
        joinButton.addTarget(self, action: #selector(joinRoomTapped), for: .touchUpInside)
    }
    
    @objc private func joinRoomTapped() {
        guard let inviteCode = inviteCodeField.text, !inviteCode.isBlank else {
            statusLabel.text = "Invite code cannot be empty."
            return
        }
        
        statusLabel.text = ""
        viewModel.joinRoom(inviteCode: inviteCode) { success in
            DispatchQueue.main.async {
                if success {
                    self.statusLabel.textColor = .green
                    self.statusLabel.text = "Successfully joined the room!"
                    self.navigationController?.popViewController(animated: true)
                    self.present(GameBoardViewController(), animated: true, completion: nil)
                } else {
                    self.statusLabel.textColor = .red
                    self.statusLabel.text = self.viewModel.error ?? "Failed to join the room."
                }
            }
        }
    }
}
