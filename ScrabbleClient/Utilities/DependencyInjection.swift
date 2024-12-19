//
//  DependencyInjection.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import Foundation

// Протокол для API клиента
protocol APIClientProtocol {
    func getPublicRooms(completion: @escaping (Result<[GetRoomsResponse], Error>) -> Void)
    func createRoom(isPrivate: Bool, completion: @escaping (Result<RoomResponse, Error>) -> Void)
    func deleteRoom(roomID: String, completion: @escaping (Result<Void, Error>) -> Void)
    func joinRoom(inviteCode: String, completion: @escaping (Result<Void, Error>) -> Void)
}

// Внедрение зависимостей с использованием APIClient
class DependencyInjection {
    static let shared = DependencyInjection()
    
    private init() {}
    
    // Пример зависимости
    func provideAPIClient() -> APIClientProtocol {
        return APIClient.shared
    }
    
    func provideRoomViewModel() -> RoomViewModel {
        return RoomViewModel(apiClient: provideAPIClient())
    }
}

