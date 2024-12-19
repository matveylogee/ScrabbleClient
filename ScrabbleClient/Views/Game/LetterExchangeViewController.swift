//
//  LetterExchangeViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class LetterExchangeViewController: UIViewController {
    
    private let lettersField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Letters to Exchange"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let exchangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exchange Letters", for: .normal)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exchange Letters"
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(lettersField)
        view.addSubview(exchangeButton)
        view.addSubview(statusLabel)
        
        let stackView = UIStackView(arrangedSubviews: [lettersField, exchangeButton, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        exchangeButton.addTarget(self, action: #selector(exchangeLettersTapped), for: .touchUpInside)
    }
    
    @objc private func exchangeLettersTapped() {
        guard let letters = lettersField.text, !letters.isEmpty else {
            statusLabel.text = "Please enter letters to exchange."
            return
        }
        
        // Логика обмена будет добавлена позже.
        statusLabel.text = "Exchanged: \(letters)"
    }
}

