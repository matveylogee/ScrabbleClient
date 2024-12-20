//
//  APIClient.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class APIClient: APIClientProtocol {
    static let shared = APIClient()
    var bearerToken: String?
    private let baseURL = Constants.API.baseURL

    // MARK: - Register
    func register(username: String, email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/v1/auth/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["username": username, "password": password, "email": email]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    completion(.success(authResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/v1/auth/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let body = ["username": username, "password": password]
//        request.httpBody = try? JSONEncoder().encode(body)
        
        let credentials = "\(email):\(password)"
        guard let credentialData = credentials.data(using: .utf8) else {
            print("Failed to encode credentials")
            return
        }
        
        let base64Credentials = credentialData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("[ DEBUG ]: login request created")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    print("[ DEBUG ]: logged in successfullly")
                    completion(.success(authResponse))
                } catch {
                    print("[ DEBUG ]: failure logging in")
                    completion(.failure(error))
                }
            } else if let error = error {
                print("[ DEBUG ]: error logging in")
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
    func createRoom(isPrivate: Bool, completion: @escaping (Result<RoomResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/create") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(bearerToken ?? "")", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = [
            "timePerTurn": 10,
            "isPrivate": isPrivate,
            "maxPlayers": 10
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let roomResponse = try JSONDecoder().decode(RoomResponse.self, from: data)
                    print("[ DEBUG ]: room created")
                    completion(.success(roomResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Delete Room
    func deleteRoom(roomID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/\(roomID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
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
    
    //MARK:  - getPublicRooms
    func getPublicRooms(completion: @escaping (Result<[GetRoomsResponse], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rooms/getPublic") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearerToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    print("[ DEBUG ]: decoding (JSONDecoder)")
                    print("[ DEBUG ]: \(String(reflecting: data))")
                    let rooms = try JSONDecoder().decode([GetRoomsResponse].self, from: data)
                    completion(.success(rooms))
                } catch {
                    completion(.failure(error))
                    print(" [ERROR]: \(String(reflecting: error))")
                }
            } else if let error = error {
                print(" [ERROR]: \(String(reflecting: error))")
                completion(.failure(error))
            }
        }.resume()
    }
}
