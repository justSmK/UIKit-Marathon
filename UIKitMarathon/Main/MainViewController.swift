//
//  MainViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var tasks = Tasks()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        setupTasks()
        print(tasks.first?.id)
        print(tasks.first?.title)
        print(tasks.first?.text)
        print(tasks.first?.url)
        
//        print(tasks[1].id)
//        print(tasks[1].title)
//        print(tasks[1].text)
//        print(tasks[1].url)
    }

    
    private func setupTasks() {
        var arrayOfNames = [String]()
        var ids = [UInt8]()
        
        for i in 1...9 {
            let fileName = "Task\(i)Text_base64"
            arrayOfNames.append(fileName)
            ids.append(UInt8(i))
        }
        
        for (index, name) in arrayOfNames.enumerated() {
            guard let file = Bundle.main.url(forResource: name, withExtension: "txt") else {
                fatalError("Couldn't find \(name) in main bundle")
            }
            
            do {
                let contents = try String(contentsOf: file, encoding: .utf8)
                
                if let data = Data(base64Encoded: contents), let decodedString = String(data: data, encoding: .utf8) {
                    let splitContent = decodedString.split(separator: "#")
                    
                    let id = ids[index]
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
                    print("Base64 decoding failed.")
                }
                
            } catch {
                print("Error reading: \(error.localizedDescription)")
            }
        }
    }

}

