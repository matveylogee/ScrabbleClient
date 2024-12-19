//
//  CreateRoomViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class CreateRoomViewController: UIViewController {
    
    private let viewModel: RoomViewModel
        
    init(viewModel: RoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Room Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let privateSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let privateSwiftLabel: UILabel = {
        let label = UILabel()
        label.text = "Is room private"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let createButton = CustomButton()
    private let errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Room"
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(nameField)
        view.addSubview(privateSwitch)
        view.addSubview(privateSwiftLabel)
        view.addSubview(createButton)
        view.addSubview(errorView)
        
        errorView.frame = view.bounds
        errorView.isHidden = true
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        privateSwitch.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        privateSwiftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            nameField.widthAnchor.constraint(equalToConstant: 250),
            
            privateSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privateSwitch.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            
            privateSwiftLabel.leadingAnchor.constraint(equalTo: privateSwitch.leadingAnchor, constant: 60),
            privateSwiftLabel.centerYAnchor.constraint(equalTo: privateSwitch.centerYAnchor),
            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: privateSwitch.bottomAnchor, constant: 20),
            createButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        createButton.setTitle("Create Room")
        createButton.addTarget(self, action: #selector(createRoomTapped), for: .touchUpInside)
    }
    
    @objc private func createRoomTapped() {
//        guard let name = nameField.text, !name.isEmpty else {
//            errorView.setError("Room name cannot be empty.")
//            errorView.isHidden = false
//            return
//        }
        
        errorView.isHidden = true
        viewModel.createRoom(isPrivate: privateSwitch.isOn) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.errorView.setError("Failed to create room. Try again.")
                    self?.errorView.isHidden = false
                }
            }
        }
    }
}
