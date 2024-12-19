//
//  AuthResponse.swift
//  ScrabbleClient
//
//  Created by br3nd4nt on 19.12.2024.
//

struct AuthResponse: Codable {
    let user: User
    let id: String
    let value: String // Token

    struct User: Codable {
        let id: String
    }
}
