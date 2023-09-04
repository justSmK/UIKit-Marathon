//
//  AssemblyBuilder.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createInitialSetup() -> (UINavigationController, RouterProtocol) {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        router.initialViewController()
        return (navigationController, router)
    }
    
    func createMain(router: RouterProtocol) -> UIViewController {
        let view = MainCollectionViewController()
        
        let presenter = MainPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createBridge(task: Task, router: RouterProtocol) -> UIViewController {
        let view = BridgeViewController()
        
        return view
    }
}
