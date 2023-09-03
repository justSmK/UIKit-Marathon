//
//  AppDelegate.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var orientationLook = UIInterfaceOrientationMask.portrait

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return self.orientationLook
    }
}

