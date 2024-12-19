//
//  GameStatus.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

struct GameStatus: Codable {
    let scoreboard: [String: Int]
    let isFinished: Bool
    let winner: String?
}
