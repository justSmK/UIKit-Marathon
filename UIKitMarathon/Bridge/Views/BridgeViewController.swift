//
//  BridgeViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class BridgeViewController: UIViewController {
    
    var presenter: BridgePresenterProtocol?
    
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
        textView.backgroundColor = AppColors.backgroundTextViewContent
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.layer.cornerRadius = 10
        textView.layer.cornerCurve = .continuous
        textView.font = AppFonts.textViewContent
        textView.textLayoutManager?.usesHyphenation = true
        return textView
    }()
    
    private lazy var buttonShowVideo: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.setTitle(LocalizationKeys.showVideo, for: .normal)
        button.addTarget(self, action: #selector(showVideoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonShowYouTubeVideo: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.setTitle(LocalizationKeys.showYouTubeSolution, for: .normal)
        button.addTarget(self, action: #selector(showYouTubeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonShowSolution: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizationKeys.showSolution, for: .normal)
        button.titleLabel?.font = AppFonts.buttonShowSolution
        button.addTarget(self, action: #selector(showSolutionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.tintColor = .link
        navigationController?.navigationBar.prefersLargeTitles = false
        view.preservesSuperviewLayoutMargins = false
    }
    
    private func fillData() {
        textViewContent.text = presenter?.task.text
        presenter?.prepareVideo()
    }
    
    private func setupView() {
        view.backgroundColor = AppColors.background
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textViewContent)
        stackView.addArrangedSubview(buttonShowVideo)
        stackView.addArrangedSubview(buttonShowYouTubeVideo)
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
        presenter?.showTaskViewController()
    }
    
    @objc
    private func showVideoButtonTapped(_ sender: UIButton) {
        presenter?.playVideo()
    }
    
    @objc
    private func showYouTubeButtonTapped(_ sender: UIButton) {
        presenter?.openYouTubeVideo()
    }
}

extension BridgeViewController: BridgeViewProtocol {}
