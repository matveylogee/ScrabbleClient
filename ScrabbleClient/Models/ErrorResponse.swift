//
//  ErrorResponse.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String
    let code: Int
}
