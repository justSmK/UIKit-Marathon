//
//  TaskDecodingService.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/5/23.
//

import Foundation

final class TaskDecodingService: TaskDecodingServiceProtocol {
    func decodeTask(from name: String, id: UInt8) -> Task? {
        guard let file = Bundle.main.url(forResource: name, withExtension: "txt") else {
            print("Couldn't find \(name) in main bundle")
            return nil
        }
        
        do {
            let contents = try String(contentsOf: file, encoding: .utf8)
            
            if let data = Data(base64Encoded: contents),
               let decodedString = String(data: data, encoding: .utf8) {
                
                let splitContent = decodedString.split(separator: "#")
                
                let title = String(splitContent[0])
                let text = String(splitContent[1])
                let urlString = String(splitContent[2]).trimmingCharacters(in: .whitespacesAndNewlines)
                
                if let url = URL(string: urlString) {
                    return Task(id: id, title: title, text: text, url: url)
                } else {
                    print("Invalid URL string.")
                    return nil
                }
                
            } else {
                print("Base64 \(id) \(name) decoding failed.")
                return nil
            }
            
        } catch {
            print("Error reading: \(error.localizedDescription)")
            return nil
        }
    }
}
