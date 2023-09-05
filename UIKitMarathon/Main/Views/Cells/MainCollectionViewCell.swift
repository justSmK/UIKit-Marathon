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
        contentView.backgroundColor = AppColors.backgroundViewCell
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.cornerCurve = .continuous
    }
    
    private func setupLayout() {
        contentView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
    }
    
    // MARK: - Internal methods
    
    func setupViewCell(title: String) {
        labelTitle.text = title
    }
}
