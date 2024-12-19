//
//  LeaderboardViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    private let viewModel = LeaderboardViewModel()
    private let tableView = UITableView()
    private let loadingView = LoadingView()
    private var leaderboard: [(name: String, score: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaderboard"
        view.backgroundColor = .white
        setupTableView()
        setupLoadingView()
        fetchLeaderboard()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LeaderboardCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLoadingView() {
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
    }
    
    private func fetchLeaderboard() {
        loadingView.isHidden = false
        viewModel.updateLeaderboard(roomID: 1) { [weak self] in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                self?.leaderboard = self?.viewModel.leaderboard
                    .map { ($0.key, $0.value) }
                    .sorted { $0.score > $1.score } ?? []
                self?.tableView.reloadData()
            }
        }
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        let player = leaderboard[indexPath.row]
        cell.textLabel?.text = "\(player.name): \(player.score)"
        return cell
    }
}
