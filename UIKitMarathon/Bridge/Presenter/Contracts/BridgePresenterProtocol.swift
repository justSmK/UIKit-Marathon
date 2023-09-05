//
//  BridgePresenterProtocol.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import Foundation

protocol BridgePresenterProtocol: AnyObject {
    var task: Task { get }
    func showTaskViewController()
    func prepareVideo()
    func playVideo()
    func openYouTubeVideo()
}
