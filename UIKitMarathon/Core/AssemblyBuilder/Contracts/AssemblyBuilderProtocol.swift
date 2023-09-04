//
//  AssemblyBuilderProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit.UINavigationController

protocol AssemblyBuilderProtocol {
    func createInitialSetup() -> (UINavigationController, RouterProtocol)
    func createMain(router: RouterProtocol) -> UIViewController
    func createBridge(task: Task, router: RouterProtocol) -> UIViewController
    func createTaskViewController(id: UInt8) -> UIViewController
}
