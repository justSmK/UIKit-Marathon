//
//  MainViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import UIKit

import AVFoundation
import AVKit

final class MainViewController: UIViewController {
    
    var player: AVPlayer?
    
    private var tasks = Tasks()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        setupTasks()
//        print(tasks.first?.id)
//        print(tasks.first?.title)
//        print(tasks.first?.text)
//        print(tasks.first?.url)
        
//        print(tasks[1].id)
//        print(tasks[1].title)
//        print(tasks[1].text)
//        print(tasks[1].url)
        
        prepareVideoForPlayer()
    }

    
    private func setupTasks() {
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
    
    private func testVideos() {
        if let path = Bundle.main.path(forResource: "Task1", ofType: "mp4") {
            print("Success")
            let videoURL = URL(fileURLWithPath: path)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                player.play()
            }
            
        }
    }
    
    private func prepareVideoForPlayer() {
        if let path = Bundle.main.path(forResource: "Task1", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Инициализация AVPlayer
            player = AVPlayer(url: videoURL)
            
            // Создание AVPlayerLayer и привязка его к AVPlayer
            let playerLayer = AVPlayerLayer(player: player)
            
            // Установка размера и положения
            playerLayer.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            
            // Добавление playerLayer как sublayer к UIView
            self.view.layer.addSublayer(playerLayer)
            
            // Запуск видео
            player?.play()
        }
    }
    
}

