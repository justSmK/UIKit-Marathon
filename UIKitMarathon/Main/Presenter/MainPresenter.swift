//
//  MainPresenter.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainCollectionViewProtocol?
    
    private let taskDecodingService: TaskDecodingServiceProtocol
    
    private let router: RouterProtocol
    
    var tasks = Tasks()
    
    init(
        view: MainCollectionViewProtocol,
        taskDecodingService: TaskDecodingServiceProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.taskDecodingService = taskDecodingService
        self.router = router
    }
    
    func getTasks() {
        setupTasks()
        view?.updateData(with: tasks)
    }
    
    func tapOnTheCell(task: Task) {
        router.showBridgeViewController(task: task)
    }
}

private extension MainPresenter {
    func setupTasks() {
        let (arrayOfNames, ids) = setupArrayOfNames()
        
        for (index, name) in arrayOfNames.enumerated() {
            let id = ids[index]
            if let task = taskDecodingService.decodeTask(from: name, id: id) {
                tasks.append(task)
            }
        }
    }
    
    func setupArrayOfNames() -> (arrayOfNames: [String], ids: [UInt8]) {
        let currentLocale = Locale.current.identifier
        
        var arrayOfNames = [String]()
        var ids = [UInt8]()
        
        for i in 1...9 {
            var fileName = String()
            if currentLocale.contains("ru") || currentLocale.contains("RU") {
                fileName = "Task\(i)Text_base64"
            } else {
                fileName = "Task\(i)Text_base64_en"
            }
            arrayOfNames.append(fileName)
            ids.append(UInt8(i))
        }
        
        return (arrayOfNames, ids)
    }
}
