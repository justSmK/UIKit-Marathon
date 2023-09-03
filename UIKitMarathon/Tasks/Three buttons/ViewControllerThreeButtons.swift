//
//  ViewController.swift
//  Three buttons
//
//  Created by Sergei Semko on 5/4/23.
//

import UIKit

class ViewControllerThreeButtons: UIViewController {
    
    lazy var firstButton = Button(title: "First button")
    lazy var secondButton = Button(title: "Second Middle Button")
    lazy var thirdButton = Button(title: "Third")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        
        thirdButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if firstButton.transform == .identity && secondButton.transform == .identity && thirdButton.transform == .identity {
            firstButton.setInsets()
            firstButton.center.x = view.frame.width / 2
            firstButton.frame.origin.y = view.safeAreaInsets.top
            
            secondButton.setInsets()
            secondButton.center.x = firstButton.center.x
            secondButton.frame.origin.y = firstButton.frame.maxY + 8
            
            thirdButton.setInsets()
            thirdButton.center.x = secondButton.center.x
            thirdButton.frame.origin.y = secondButton.frame.maxY + 8
        }
        
    }
    
    @objc func buttonDidTap() {
        let viewVC = UIViewController()
        viewVC.view.backgroundColor = .systemBackground
        present(viewVC, animated: true)
    }
}


class Button: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = self.isHighlighted ? .init(scaleX: 0.94, y: 0.94) : .identity
            }
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        
        setImage(.init(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(.init(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        
        tintColorDidChange()
        
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        
        
    }
    
    
    override func tintColorDidChange() {
        print("Tint color did change \(self.tintAdjustmentMode)")
        super.tintColorDidChange()
        if tintAdjustmentMode == .dimmed {
            self.imageView?.tintColor = .systemGray3
            self.setTitleColor(.systemGray3, for: .normal)
            self.backgroundColor = .systemGray2
        } else {
            self.imageView?.tintColor = .white
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .systemBlue
        }
    }
    
    func setInsets() {
        
        let titleImageSpacing: CGFloat = 8
        
        contentEdgeInsets = .init(top: 10, left: 14, bottom: 10, right: 14 + titleImageSpacing)
        sizeToFit()
        
        let imageWidth = imageView?.frame.width ?? .zero
        self.titleEdgeInsets = .init(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
        let titleWidth = titleLabel?.frame.width ?? .zero
        self.imageEdgeInsets = .init(top: 0, left: titleWidth + titleImageSpacing, bottom: 0, right: -titleWidth - titleImageSpacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
