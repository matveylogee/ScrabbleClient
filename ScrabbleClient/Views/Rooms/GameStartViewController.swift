//
//  GameStartViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 19.12.2024.
//

import UIKit

class GameStartViewController: UIViewController {
    
    var bearerToken: String?
    
    private let roomLabel: UILabel = {
        let label = UILabel()
        label.text = "Room"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()

    private let createRoomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать комнату", for: .normal)

        return button
    }()
    
    private let joinRoomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Присоединиться по коду", for: .normal)

        return button
    }()
    
    private let roomListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Список комнат", for: .normal)

        return button
    }()
    
    private let leaveAccount: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Начать игру"
        view.backgroundColor = .white
        setupViews()
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
        view.addSubview(roomLabel)
        view.addSubview(createRoomButton)
        view.addSubview(joinRoomButton)
        view.addSubview(roomListButton)
        view.addSubview(leaveAccount)
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        createRoomButton.translatesAutoresizingMaskIntoConstraints = false
        joinRoomButton.translatesAutoresizingMaskIntoConstraints = false
        roomListButton.translatesAutoresizingMaskIntoConstraints = false
        leaveAccount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 200),

            createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createRoomButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            createRoomButton.widthAnchor.constraint(equalToConstant: 250),
            
            joinRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinRoomButton.topAnchor.constraint(equalTo: createRoomButton.bottomAnchor, constant: 20),
            joinRoomButton.widthAnchor.constraint(equalToConstant: 250),
            
            roomListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomListButton.topAnchor.constraint(equalTo: joinRoomButton.bottomAnchor, constant: 20),
            roomListButton.widthAnchor.constraint(equalToConstant: 250),
            
            leaveAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leaveAccount.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            leaveAccount.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        joinRoomButton.addTarget(self, action: #selector(joinRoomTapped), for: .touchUpInside)
        createRoomButton.addTarget(self, action: #selector(createRoomTapped), for: .touchUpInside)
        roomListButton.addTarget(self, action: #selector(roomListTapped), for: .touchUpInside)
        leaveAccount.addTarget(self, action: #selector(leaveAccountTapped), for: .touchUpInside)
    }
    
    @objc private func createRoomTapped() {
        let viewModel = RoomViewModel(apiClient: DependencyInjection.shared.provideAPIClient())
        let createRoomVC = CreateRoomViewController(viewModel: viewModel)
        navigationController?.pushViewController(createRoomVC, animated: true)
    }
    
    @objc private func joinRoomTapped() {
        let viewModel = RoomViewModel(apiClient: DependencyInjection.shared.provideAPIClient())
        let joinRoomVC = JoinRoomViewController(viewModel: viewModel)
        navigationController?.pushViewController(joinRoomVC, animated: true)
    }
    
    @objc private func roomListTapped() {
        let viewModel = RoomViewModel(apiClient: DependencyInjection.shared.provideAPIClient())
        let roomListVC = RoomListViewController(viewModel: viewModel)
        navigationController?.pushViewController(roomListVC, animated: true)
    }
    
    @objc private func leaveAccountTapped() {
        APIClient.shared.bearerToken = ""
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

