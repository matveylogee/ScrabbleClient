//
//  Constants.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "http://localhost:8080/api" // Замените на ваш URL сервера
    }
    
    struct Messages {
        static let genericError = "Something went wrong. Please try again later."
        static let networkError = "Failed to connect to the server. Check your internet connection."
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 8.0
    }
}
