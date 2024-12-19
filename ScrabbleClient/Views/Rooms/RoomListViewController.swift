//
//  RoomListViewController.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

class RoomListViewController: UIViewController {
    
    private let viewModel = RoomViewModel(apiClient: DependencyInjection.shared.provideAPIClient())
    private var tableView = UITableView()
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rooms"
        view.backgroundColor = .white
        setupTableView()
        setupLoadingAndErrorViews()
        fetchRooms()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RoomCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLoadingAndErrorViews() {
        // Добавление LoadingView
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        
        // Добавление ErrorView
        errorView.frame = view.bounds
        errorView.isHidden = true
        errorView.onRetry = { [weak self] in
            self?.fetchRooms()
        }
        view.addSubview(errorView)
    }
    
    private func fetchRooms() {
        loadingView.isHidden = false
        errorView.isHidden = true
        
        viewModel.fetchRooms { [weak self] in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                if self?.viewModel.error != nil {
                    self?.errorView.setError("Failed to load rooms. Please try again.")
                    self?.errorView.isHidden = false
                } else {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension RoomListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)
        let room = viewModel.rooms[indexPath.row]
        cell.textLabel?.text = room.name
        return cell
    }
}
