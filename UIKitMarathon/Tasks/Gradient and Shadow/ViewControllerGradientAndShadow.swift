//
//  ViewController.swift
//  Gradient and Shadow
//
//  Created by Sergei Semko on 5/1/23.
//

import UIKit

class ViewControllerGradientAndShadow: UIViewController {
    
    lazy var cyanView = View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        cyanView.layer.cornerRadius = 14
        cyanView.backgroundColor = .systemCyan
        view.addSubview(cyanView)
        
        AppOrientationUtility.lockOrientation(.all)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cyanView.frame = .init(x: 100, y: cyanView.frame.origin.y, width: 120, height: 120)
        cyanView.center.y = view.frame.height / 2
    }
    
    deinit {
        AppOrientationUtility.lockOrientation(.portrait)
    }
}

class View: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemCyan
        layer.cornerCurve = .continuous
        
//        layer.masksToBounds = true // wrong
        
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: .zero, height: 12)
        layer.shadowRadius = 12
        
        gradientLayer.startPoint = .init(x: 0, y: 0)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        gradientLayer.colors = [UIColor.systemRed.withAlphaComponent(0.1), UIColor.systemRed.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        if layer == self.layer {
            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = layer.cornerRadius
        }
    }
    
}
