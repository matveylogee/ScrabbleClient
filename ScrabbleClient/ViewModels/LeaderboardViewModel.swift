//
//  AuthViewModel.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class LeaderboardViewModel {
    private var apiClient = APIClient.shared
    var leaderboard: [String: Int] = [:]
    var error: String?

    // Обновление лидерборда
    func updateLeaderboard(roomID: Int, completion: @escaping () -> Void) {
        apiClient.getGameStatus(roomID: roomID) { result in
            switch result {
            case .success(let gameStatus):
                self.leaderboard = gameStatus.scoreboard
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }

    // Получение текущего лидера
    func getCurrentLeader() -> (name: String, score: Int)? {
        if let leader = leaderboard.max(by: { $0.value < $1.value }) {
            return (name: leader.key, score: leader.value)
        }
        return nil
    }

}

