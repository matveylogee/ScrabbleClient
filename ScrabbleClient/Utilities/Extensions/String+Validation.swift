//
//  String+Validation.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

// MARK: - String + Validation
extension String {
    var isValidUsername: Bool {
        let regex = "^[a-zA-Z0-9_-]{3,16}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$" // Минимум 6 символов, одна буква и одна цифра
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    /// Проверяет, является ли строка корректным email
    var isValidEmail: Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    /// Проверяет, является ли строка пустой или содержит только пробелы
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
