//
//  APIClient.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let baseURL = Constants.API.baseURL

    // MARK: - Register
    func register(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Login
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Delete account
    func deleteAccount(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }

    
    // MARK: - Start Game
    func startGame(roomID: Int, completion: @escaping (Result<GameStatus, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)/start") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let gameStatus = try JSONDecoder().decode(GameStatus.self, from: data)
                    completion(.success(gameStatus))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Place Word
    func placeWord(roomID: Int, word: String, position: (x: Int, y: Int), direction: String, completion: @escaping (Result<GameStatus, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)/placeWord") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "word": word,
            "position": ["x": position.x, "y": position.y],
            "direction": direction
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let gameStatus = try JSONDecoder().decode(GameStatus.self, from: data)
                    completion(.success(gameStatus))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Get Game Status
    func getGameStatus(roomID: Int, completion: @escaping (Result<GameStatus, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)/status") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let gameStatus = try JSONDecoder().decode(GameStatus.self, from: data)
                    completion(.success(gameStatus))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - End Game
    func endGame(roomID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)/end") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
    
    // MARK: - Create Room
    func createRoom(name: String, isPrivate: Bool, completion: @escaping (Result<Room, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name": name,
            "isPrivate": isPrivate
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let room = try JSONDecoder().decode(Room.self, from: data)
                    completion(.success(room))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Delete Room
    func deleteRoom(roomID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }

    // MARK: - Fetch Rooms
    func fetchRooms(completion: @escaping (Result<[Room], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let rooms = try JSONDecoder().decode([Room].self, from: data)
                    completion(.success(rooms))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Join Room
    func joinRoom(inviteCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/join") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["inviteCode": inviteCode]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
}
