//
//  BridgePresenter.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import Foundation
import AVFoundation
import UIKit.UIApplication
import AVKit

final class BridgePresenter: BridgePresenterProtocol {
    
    var task: Task
    
    private weak var view: BridgeViewProtocol?
    
    private let router: RouterProtocol
    
    private var player: AVPlayer?
    
    init(view: BridgeViewProtocol, task: Task, router: RouterProtocol) {
        self.view = view
        self.task = task
        self.router = router
    }
    
    func showTaskViewController() {
        let id = task.id
        router.showTaskViewController(id: id)
    }
    
    func prepareVideo() {
        let id = task.id
        if let path = Bundle.main.path(forResource: "Task\(id)", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: path)
            player = AVPlayer(url: videoURL)
        }
    }
    
    func playVideo() {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        view?.present(playerViewController, animated: true, completion: { [weak self] in
            self?.player?.play()
        })
    }
    
    func openYouTubeVideo() {
        let url = task.url
        UIApplication.shared.open(url)
    }
}
