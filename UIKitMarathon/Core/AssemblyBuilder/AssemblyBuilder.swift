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
        
        let decodingService = TaskDecodingService()
        
        let presenter = MainPresenter(
            view: view,
            taskDecodingService: decodingService,
            router: router
        )
        
        view.presenter = presenter
        
        return view
    }
    
    func createBridge(task: Task, router: RouterProtocol) -> UIViewController {
        let view = BridgeViewController()
        
        let presenter = BridgePresenter(view: view, task: task, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createTaskViewController(id: UInt8) -> UIViewController {
        switch id {
        case 1:
            return ViewControllerGradientAndShadow()
        case 2:
            return ViewControllerThreeButtons()
        case 3:
            return ViewControllerLinkedAnimation()
        case 4:
            return ViewControllerMixerTable()
        case 5:
            return ViewControllerCompactController()
        case 6:
            return ViewControllerInertialSquare()
        case 7:
            return ViewControllerStretchingPicture()
        case 8:
            return ViewControllerNativeAvatar()
        case 9:
            return CollectionViewControllerCaringCollection()
        default:
            return UIViewController()
        }
    }
}
