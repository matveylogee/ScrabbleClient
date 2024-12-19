//
//  AuthViewModel.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class AuthViewModel {
    var authResponse: AuthResponse?
    var error: String?

    func register(username: String, email: String, password: String, completion: @escaping () -> Void) {
        APIClient.shared.register(username: username, email: email, password: password) { result in
            switch result {
            case .success(let authResponse):
                self.authResponse = authResponse
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }

    func login(email: String, password: String, completion: @escaping () -> Void) {
        APIClient.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let authResponse):
                self.authResponse = authResponse
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }
    
    func deleteAccount(username: String, completion: @escaping (Bool) -> Void) {
        APIClient.shared.deleteAccount(username: username) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self.error = error.localizedDescription
                completion(false)
            }
        }
    }

}

