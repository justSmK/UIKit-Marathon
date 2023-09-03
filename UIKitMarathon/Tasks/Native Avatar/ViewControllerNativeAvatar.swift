//
//  ViewControllerNativeAvatar.swift
//  UIKit Marathon
//
//  Created by Sergei Semko on 7/21/23.
//

import UIKit

class ViewControllerNativeAvatar: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width: view.frame.width, height: 2000)

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
    }
    
    let avatarImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Avatar"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.delegate = self
        
        avatarImage.image = .init(systemName: "person.crop.circle.fill")
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.tintColor = .systemGray3
    }
    
}

extension ViewControllerNativeAvatar: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        guard viewController == self else {
            avatarImage.removeFromSuperview()
            return
        }
        
        let navBar = navigationController.navigationBar
        DispatchQueue.main.async {
            let avatarImage = self.avatarImage
            navBar.subviews.forEach { subview in
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                guard stringFromClass.contains("UINavigationBarLargeTitleView") else { return }
                
                if avatarImage.superview != subview {
                    avatarImage.removeFromSuperview()
                    subview.addSubview(avatarImage)
                }
                
                avatarImage.translatesAutoresizingMaskIntoConstraints = false
                avatarImage.removeConstraints(avatarImage.constraints)
                
                avatarImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
                avatarImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
                avatarImage.bottomAnchor.constraint(equalTo: avatarImage.superview!.bottomAnchor, constant: -10).isActive = true
                avatarImage.trailingAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
                
            }
        }
    }
}
