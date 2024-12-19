//
//  RoomDetailsViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class RoomDetailsViewController: UIViewController {
    
    private let room: Room
    private let viewModel = RoomViewModel(apiClient: DependencyInjection.shared.provideAPIClient())
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Room", for: .normal)
        button.tintColor = .red
        return button
    }()
    
    init(room: Room) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
        title = room.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        deleteButton.addTarget(self, action: #selector(deleteRoomTapped), for: .touchUpInside)
    }
    
    @objc private func deleteRoomTapped() {
        viewModel.deleteRoom(roomID: room.id) { success in
            DispatchQueue.main.async {
                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Failed to delete room.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

