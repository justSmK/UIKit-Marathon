//
//  SceneDelegate.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let assemblyBuilder = AssemblyBuilder()
        let (navigationController, _) = assemblyBuilder.createInitialSetup()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

