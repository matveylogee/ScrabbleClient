//
//  GameBoardViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    private let viewModel = GameViewModel()
    
    private let wordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Word"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let positionXField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "X Position"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let positionYField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Y Position"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let directionSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Horizontal", "Vertical"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private let placeWordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Place Word", for: .normal)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Game Board"
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(wordField)
        view.addSubview(positionXField)
        view.addSubview(positionYField)
        view.addSubview(directionSegment)
        view.addSubview(placeWordButton)
        view.addSubview(statusLabel)
        
        // Layout
        let stackView = UIStackView(arrangedSubviews: [wordField, positionXField, positionYField, directionSegment, placeWordButton, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        placeWordButton.addTarget(self, action: #selector(placeWordTapped), for: .touchUpInside)
    }
    
    @objc private func placeWordTapped() {
        guard let word = wordField.text, !word.isEmpty,
              let posX = Int(positionXField.text ?? ""),
              let posY = Int(positionYField.text ?? "") else {
            statusLabel.text = "Please fill all fields correctly."
            return
        }
        
        let direction = directionSegment.selectedSegmentIndex == 0 ? "horizontal" : "vertical"
        
        viewModel.placeWord(roomID: 1, word: word, position: (x: posX, y: posY), direction: direction) { success in
            DispatchQueue.main.async {
                self.statusLabel.text = success ? "Word placed successfully." : "Failed to place word."
            }
        }
    }
}

