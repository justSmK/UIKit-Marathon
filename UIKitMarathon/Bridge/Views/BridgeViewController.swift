//
//  BridgeViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class BridgeViewController: UIViewController {
    
    var presenter: BridgePresenterProtocol?
    
    private var item: IndexPath.Element?
    
    private lazy var textViewContent: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.layer.cornerRadius = 25
        textView.font = .systemFont(ofSize: 22)
        textView.layer.cornerCurve = .continuous
        textView.textLayoutManager?.usesHyphenation = true
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show solution", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.cornerCurve = .continuous
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .link
        navigationController?.navigationBar.prefersLargeTitles = false
        view.preservesSuperviewLayoutMargins = false
    }
    
    private func setupView() {
        view.addSubview(textViewContent)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: textViewContent.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textViewContent.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 100),
            
            textViewContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textViewContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textViewContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textViewContent.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ])
    }
    
    public func settingsData(title: String, text: String, item: IndexPath.Element) {
        self.title = title
        textViewContent.text = text
        self.item = item
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        guard let item else { return }
        showViewController(item: item)
    }
    
    private func showViewController(item: IndexPath.Element) {
        var viewController: UIViewController
        switch item {
        case 0:
            viewController = ViewControllerGradientAndShadow()
        case 1:
            viewController = ViewControllerThreeButtons()
        case 2:
            viewController = ViewControllerLinkedAnimation()
        case 3:
            viewController = ViewControllerMixerTable()
        case 4:
            viewController = ViewControllerCompactController()
        case 5:
            viewController = ViewControllerInertialSquare()
        case 6:
            viewController = ViewControllerStretchingPicture()
        case 7:
            viewController = ViewControllerNativeAvatar()
        case 8:
            viewController = CollectionViewControllerCaringCollection()
        default:
            viewController = UIViewController()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BridgeViewController: BridgeViewProtocol {
    
}
