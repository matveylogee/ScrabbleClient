//
//  Room.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

struct Room: Codable {
    let id: Int
    let name: String
    let isPrivate: Bool
    let inviteCode: String?
}
