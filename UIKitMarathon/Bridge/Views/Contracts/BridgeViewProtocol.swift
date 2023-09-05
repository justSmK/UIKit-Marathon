//
//  BridgeViewProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit.UIViewController

protocol BridgeViewProtocol: AnyObject {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}
