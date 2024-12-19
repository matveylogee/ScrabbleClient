//
//  GameStartViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 19.12.2024.
//

import UIKit

class GameStartViewController: UIViewController {
    
    var bearerToken: String?

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Начать игру"
        view.backgroundColor = .white
        setupViews()
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
        view.addSubview(createRoomButton)
        view.addSubview(joinRoomButton)
        view.addSubview(roomListButton)
        
        createRoomButton.translatesAutoresizingMaskIntoConstraints = false
        joinRoomButton.translatesAutoresizingMaskIntoConstraints = false
        roomListButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createRoomButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            createRoomButton.widthAnchor.constraint(equalToConstant: 250),
            
            joinRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinRoomButton.topAnchor.constraint(equalTo: createRoomButton.bottomAnchor, constant: 20),
            joinRoomButton.widthAnchor.constraint(equalToConstant: 250),
            
            roomListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomListButton.topAnchor.constraint(equalTo: joinRoomButton.bottomAnchor, constant: 20),
            roomListButton.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        joinRoomButton.addTarget(self, action: #selector(joinRoomTapped), for: .touchUpInside)
        createRoomButton.addTarget(self, action: #selector(createRoomTapped), for: .touchUpInside)
        roomListButton.addTarget(self, action: #selector(roomListTapped), for: .touchUpInside)
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
}

