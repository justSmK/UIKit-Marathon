//
//  RouterProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit.UINavigationController

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showBridgeViewController(task: Task)
    func pop(to viewController: UIViewController)
    func popToRoot()
}
