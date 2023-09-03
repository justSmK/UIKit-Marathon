//
//  CollectionViewController.swift
//  Caring Collection
//
//  Created by Sergei Semko on 5/25/23.
//

import UIKit

class LayoutCaringCollection: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        itemSize = .init(width: 280, height: 400)
        sectionInsetReference = .fromLayoutMargins
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let horizontalOffset = proposedContentOffset.x
        let targetRect = CGRect.init(origin: .init(x: proposedContentOffset.x, y: 0), size: collectionView.bounds.size)
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            
            if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint.init(x: proposedContentOffset.x + offsetAdjustment - collectionView.layoutMargins.left, y: proposedContentOffset.y)
    }
    
}

class CollectionViewControllerCaringCollection: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: LayoutCaringCollection())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.preservesSuperviewLayoutMargins = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGroupedBackground
        cell.layer.cornerCurve = .continuous
        cell.layer.cornerRadius = 12
        return cell
    }
}
