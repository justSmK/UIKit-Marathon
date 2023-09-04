//
//  MainPresenter.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainCollectionViewProtocol?
    
    private let router: RouterProtocol
    
    var tasks = Tasks()
    
    init(view: MainCollectionViewProtocol, router: RouterProtocol) {
        self.view = view
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
            decode(id: id, name: name)
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
    
    func decode(id: UInt8, name: String) {
        guard let file = Bundle.main.url(forResource: name, withExtension: "txt") else {
            fatalError("Couldn't find \(name) in main bundle")
        }
        
        do {
            let contents = try String(contentsOf: file, encoding: .utf8)
            
            if let data = Data(base64Encoded: contents), let decodedString = String(data: data, encoding: .utf8) {
                let splitContent = decodedString.split(separator: "#")
                
                let id = id
                let title = String(splitContent[0])
                let text = String(splitContent[1])
                let urlString = String(splitContent[2]).trimmingCharacters(in: .whitespacesAndNewlines)
                
                if let url = URL(string: urlString) {
                    let task = Task(id: id, title: title, text: text, url: url)
                    tasks.append(task)
                } else {
                    print("Invalid URL string.")
                }
                
            } else {
                print("Base64 \(id) \(name) decoding failed.")
            }
            
        } catch {
            print("Error reading: \(error.localizedDescription)")
        }
    }
}
