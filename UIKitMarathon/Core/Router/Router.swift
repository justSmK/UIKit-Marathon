//
//  Router.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    
    func initialViewController() {
        if let navigationController {
            guard let mainCollectionViewController = assemblyBuilder?.createMain(router: self) else { return }
            navigationController.viewControllers = [mainCollectionViewController]
        }
    }
    
    func showBridgeViewController(task: Task) {
        if let navigationController {
            guard let bridgeViewController = assemblyBuilder?.createBridge(task: task, router: self) else { return }
            navigationController.pushViewController(bridgeViewController, animated: true)
        }
    }
    
    func showTaskViewController(id: UInt8) {
        if let navigationController {
            guard let taskViewController = assemblyBuilder?.createTaskViewController(id: id) else { return }
            navigationController.pushViewController(taskViewController, animated: true)
        }
    }
    
    func pop(to viewController: UIViewController) {
        if let navigationController {
            navigationController.popToViewController(viewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}
