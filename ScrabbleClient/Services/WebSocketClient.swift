//
//  APIClient.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

//import Foundation
//
//protocol WebSocketClientDelegate: AnyObject {
//    func webSocketDidReceiveMessage(_ client: WebSocketClient, message: String)
//    func webSocketDidDisconnect(_ client: WebSocketClient, error: Error?)
//}
//
//class WebSocketClient {
//    
//    private var webSocketTask: URLSessionWebSocketTask?
//    private var isConnected = false
//    private let urlSession: URLSession
//    weak var delegate: WebSocketClientDelegate?
//    
//    init(url: URL, delegate: WebSocketClientDelegate? = nil) {
//        self.urlSession = URLSession(configuration: .default)
//        self.delegate = delegate
//        self.webSocketTask = urlSession.webSocketTask(with: url)
//    }
//    
//    func connect() {
//        guard let webSocketTask = webSocketTask else {
//            print("WebSocket task is nil.")
//            return
//        }
//        
//        webSocketTask.resume()
//        isConnected = true
//        listenForMessages()
//        print("WebSocket connected.")
//    }
//    
//    func disconnect() {
//        webSocketTask?.cancel(with: .goingAway, reason: nil)
//        isConnected = false
//        print("WebSocket disconnected.")
//    }
//    
//    func sendMessage(_ message: String) {
//        guard isConnected else {
//            print("WebSocket is not connected.")
//            return
//        }
//        
//        let message = URLSessionWebSocketTask.Message.string(message)
//        webSocketTask?.send(message) { error in
//            if let error = error {
//                print("Error sending message: \(error)")
//            } else {
//                print("Message sent: \(message)")
//            }
//        }
//    }
//    
//    private func listenForMessages() {
//        guard isConnected else { return }
//        
//        webSocketTask?.receive { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let message):
//                switch message {
//                case .string(let text):
//                    self.delegate?.webSocketDidReceiveMessage(self, message: text)
//                case .data(let data):
//                    print("Received binary message of size: \(data.count)")
//                @unknown default:
//                    print("Unknown WebSocket message type received.")
//                }
//            case .failure(let error):
//                self.delegate?.webSocketDidDisconnect(self, error: error)
//            }
//            
//            self.listenForMessages() // Continue listening for messages
//        }
//    }
//}

