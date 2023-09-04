//
//  BridgeViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

import AVFoundation
import AVKit

final class BridgeViewController: UIViewController {
    
    var presenter: BridgePresenterProtocol?
    
    
//    private var player: AVPlayer?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let textViewContent: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.layer.cornerRadius = 10
        textView.layer.cornerCurve = .continuous
        textView.font = .systemFont(ofSize: 22)
        textView.textLayoutManager?.usesHyphenation = true
        return textView
    }()
    
    private lazy var buttonShowSolution: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizationKeys.showSolution, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        button.titleLabel?.font = .systemFont(ofSize: 30)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.addTarget(self, action: #selector(showSolutionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonShowVideo: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.setTitle(LocalizationKeys.showVideo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
//        button.layer.cornerRadius = 25
//        button.layer.cornerCurve = .continuous
//        button.titleLabel?.font = .systemFont(ofSize: 30)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.addTarget(self, action: #selector(showVideoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = presenter?.task.title
        
        setupView()
        
        
//        testVideos()
        
        textViewContent.text = presenter?.task.text
    }
    
    override func viewWillLayoutSubviews() {

    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.navigationBar.tintColor = .link
//        navigationController?.navigationBar.prefersLargeTitles = false
//        view.preservesSuperviewLayoutMargins = false
//    }
    
    private func setupView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textViewContent)
        stackView.addArrangedSubview(buttonShowVideo)
        stackView.addArrangedSubview(buttonShowSolution)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textViewContent.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            textViewContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
        ])
    }
    
    @objc
    private func showSolutionButtonTapped(_ sender: UIButton) {
        if let presenter {
            presenter.showTaskViewController()
        }
    }
    
    @objc
    private func showVideoButtonTapped(_ sender: UIButton) {
        if let presenter {
            let id = presenter.task.id
            showVideo(id: id)
        }
    }
    
    private func showVideo(id: UInt8) {
        if let path = Bundle.main.path(forResource: "Task\(id)", ofType: "mp4") {
            let videoURL = URL(filePath: path)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                player.play()
            }
        }
    }

    
//    private func prepareVideoForPlayer() {
//        if let path = Bundle.main.path(forResource: "Task1", ofType: "mp4") {
//            let videoURL = URL(fileURLWithPath: path)
//
//            // Инициализация AVPlayer
//            player = AVPlayer(url: videoURL)
//
//            // Создание AVPlayerLayer и привязка его к AVPlayer
//            let playerLayer = AVPlayerLayer(player: player)
//
//            playerLayer.frame = playerView.bounds
//
//            print(playerLayer.frame)
//            print(playerLayer.bounds)
//
//            playerView.layer.addSublayer(playerLayer)
//
//            player?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
//
//
//        }
//    }
}

extension BridgeViewController: BridgeViewProtocol {
    
}
