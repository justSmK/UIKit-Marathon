//
//  MainPresenterProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainCollectionViewProtocol, router: RouterProtocol)
    var tasks: Tasks { get set }
    func getTasks()
    func tapOnTheCell(task: Task)
}
