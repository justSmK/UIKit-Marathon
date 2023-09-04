//
//  Task.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import Foundation

typealias Tasks = [Task]

struct Task: Hashable {
    let id: UInt8
    let title: String
    let text: String
    let url: URL
}
