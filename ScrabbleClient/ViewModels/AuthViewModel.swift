//
//  AuthViewModel.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import Foundation

class AuthViewModel {
    var user: User?
    var error: String?

    func register(username: String, password: String, completion: @escaping () -> Void) {
        APIClient.shared.register(username: username, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.error = error.localizedDescription
            }
            completion()
        }
    }

    func login(username: String, password: String, completion: @escaping () -> Void) {
        APIClient.shared.login(username: username, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
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

