//
//  GetRoomsResponse.swift
//  ScrabbleClient
//
//  Created by br3nd4nt on 19.12.2024.
//

struct GetRoomsResponse : Codable {
    let gameStatus: String
    let id: String
    let adminID: String
    let inviteCode: String
    let timePerTurn: Int
    let maxPlayers: Int
}
