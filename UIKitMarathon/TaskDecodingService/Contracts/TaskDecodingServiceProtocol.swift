//
//  TaskDecodingServiceProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/5/23.
//

import Foundation

protocol TaskDecodingServiceProtocol {
    func decodeTask(from name: String, id: UInt8) -> Task?
}
