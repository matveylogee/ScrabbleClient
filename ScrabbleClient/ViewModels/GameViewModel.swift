//
//  AuthViewModel.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class GameViewModel {
    private var apiClient = APIClient.shared
    var gameStatus: GameStatus?
    var error: String?

    // Начало игры
    func startGame(roomID: Int, completion: @escaping (Bool) -> Void) {
        apiClient.startGame(roomID: roomID) { result in
            switch result {
            case .success(let status):
                self.gameStatus = status
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }

    // Размещение слова
    func placeWord(roomID: Int, word: String, position: (x: Int, y: Int), direction: String, completion: @escaping (Bool) -> Void) {
        apiClient.placeWord(roomID: roomID, word: word, position: position, direction: direction) { result in
            switch result {
            case .success(let status):
                self.gameStatus = status
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }

    // Получение текущего статуса игры
    func fetchGameStatus(roomID: Int, completion: @escaping () -> Void) {
        apiClient.getGameStatus(roomID: roomID) { result in
            switch result {
            case .success(let status):
                self.gameStatus = status
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }

    // Завершение игры
    func endGame(roomID: Int, completion: @escaping (Bool) -> Void) {
        apiClient.endGame(roomID: roomID) { result in
            switch result {
            case .success:
                self.gameStatus = nil
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }
}

