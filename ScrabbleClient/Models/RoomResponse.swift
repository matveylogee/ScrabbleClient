//
//  RoomResponse.swift
//  ScrabbleClient
//
//  Created by br3nd4nt on 19.12.2024.
//

struct RoomResponse: Codable {
    let inviteCode: String
    let isPrivate: Bool
    let players: [String: String]  // Dictionary with player IDs as keys and usernames as values
    let adminID: String
    let id: String
    let currentUserID: String
    let maxPlayers: Int
    let timePerTurn: Int
}
