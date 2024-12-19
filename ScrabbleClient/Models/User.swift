//
//  User.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let token: String?
}
