//
//  Room.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

struct Room: Codable {
    var id: String
    var adminId: String
    var isPrivate: Bool
    var inviteCode: String?
    
    init(from decoder: GetRoomsResponse) {
        id = "NO ID"
        adminId = decoder.adminID
        isPrivate = false // MARK: todo
        inviteCode = decoder.inviteCode
    }
    
    init() {
        id = "NO ID"
        adminId = "NO ADMIN ID"
        isPrivate = false
        inviteCode = nil
    }
}
