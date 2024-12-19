//
//  AuthViewModel.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class RoomViewModel {
    private let apiClient: APIClientProtocol
    var rooms: [Room] = []
    var error: String?
        
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    // Создание комнаты
    func createRoom(isPrivate: Bool, completion: @escaping (Bool) -> Void) {
        apiClient.createRoom(isPrivate: isPrivate) { result in
            switch result {
            case .success(let roomResponse):
                var room = Room()
                room.id = roomResponse.id
                room.adminId = roomResponse.adminID
                room.isPrivate = roomResponse.isPrivate
                room.inviteCode = roomResponse.inviteCode
                self.rooms.append(room)
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }

    // Удаление комнаты
    func deleteRoom(roomID: String, completion: @escaping (Bool) -> Void) {
        apiClient.deleteRoom(roomID: roomID) { result in
            switch result {
            case .success:
                self.rooms.removeAll { $0.id == roomID }
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }

    // Получение списка комнат
    func getPublicRooms(completion: @escaping () -> Void) {
        apiClient.getPublicRooms { result in
            switch result {
            case .success(let roomsResponse):
                self.rooms = []
                for resp in roomsResponse {
                    self.rooms.append(Room(from: resp))
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }

    // Присоединение к комнате по коду приглашения
    func joinRoom(inviteCode: String, completion: @escaping (Bool) -> Void) {
        apiClient.joinRoom(inviteCode: inviteCode) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }
}



