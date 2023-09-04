//
//  MainCollectionViewCell.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/4/23.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Private properties
    
    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
    }
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = AppFonts.labelCell
        label.textColor = AppColors.label
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setupContentView() {
//        contentView.backgroundColor = .orange
        
//        contentView.layer.borderWidth = Constants.borderWidth
//        contentView.layer.borderColor = UITraitCollection.current.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.cornerCurve = .continuous
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        switch UITraitCollection.current.userInterfaceStyle {
//        case .dark:
//            contentView.layer.borderColor = UIColor.white.cgColor
//        case .light:
//            contentView.layer.borderColor = UIColor.black.cgColor
//        case .unspecified:
//            break
//        @unknown default:
//            break
//        }
//    }
    
    private func setupLayout() {
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
    }
    
    // MARK: - Public methods
    
    public func setupViewCell(title: String) {
        labelTitle.text = title
    }
    

}
