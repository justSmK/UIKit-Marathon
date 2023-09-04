//
//  BridgePresenter.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import Foundation

final class BridgePresenter: BridgePresenterProtocol {
    
    private weak var view: BridgeViewProtocol?
    
    private let router: RouterProtocol
    
    var task: Task
    
    init(view: BridgeViewProtocol, task: Task, router: RouterProtocol) {
        self.view = view
        self.task = task
        self.router = router
    }
    
    func didTapShowViewController(id: UInt8) {
        let id = task.id
        router.showTaskViewController(id: id)
    }
}
