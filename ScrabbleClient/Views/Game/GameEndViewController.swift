//
//  File.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class GameEndViewController: UIViewController {
    
    private let winnerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Winner: TBD"
        return label
    }()
    
    init(winner: String) {
        super.init(nibName: nil, bundle: nil)
        winnerLabel.text = "Winner: \(winner)"
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
        view.addSubview(winnerLabel)
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            winnerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winnerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

