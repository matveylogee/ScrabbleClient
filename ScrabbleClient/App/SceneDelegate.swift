//
//  SceneDelegate.swift
//  ScrabbleClient
//
//  Created by Матвей on 16.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Создаем окно приложения
        window = UIWindow(windowScene: windowScene)
        
        // Устанавливаем начальный экран
        let navigationController = UINavigationController(rootViewController: RegisterViewController())
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        print("Scene connected")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("Scene disconnected")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Scene became active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Scene will resign active")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Scene will enter foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Scene entered background")
    }
}

