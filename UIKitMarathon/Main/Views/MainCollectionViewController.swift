//
//  MainViewController.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/3/23.
//

import UIKit

import AVFoundation
import AVKit

final class MainCollectionViewController: UICollectionViewController {
    
    var presenter: MainPresenterProtocol?
    
    var player: AVPlayer?
    
    private enum Section {
        case taskName
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Task>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Task>
    
    private var dataSource: DataSource?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDataSource()
        presenter?.getTasks()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let presenter {
            let task = presenter.tasks[indexPath.item]
            presenter.tapOnTheCell(task: task)
        }
    }

    private func setupLayout() {
        let layout = setupCompositionalLayout()
        self.collectionView.collectionViewLayout = layout
    }
    
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 20

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    private func setupDataSource() {
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
        
        dataSource = UICollectionViewDiffableDataSource<Section, Task>(
            collectionView: self.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.identifier,
                for: indexPath
            ) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setupViewCell(title: itemIdentifier.title)
            
            return cell
        })
    }
    
    
    private func testVideos() {
        if let path = Bundle.main.path(forResource: "Task1", ofType: "mp4") {
            print("Success")
            let videoURL = URL(fileURLWithPath: path)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                player.play()
            }
            
        }
    }
    
    private func prepareVideoForPlayer() {
        if let path = Bundle.main.path(forResource: "Task1", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Инициализация AVPlayer
            player = AVPlayer(url: videoURL)
            
            // Создание AVPlayerLayer и привязка его к AVPlayer
            let playerLayer = AVPlayerLayer(player: player)
            
            // Установка размера и положения
            playerLayer.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            
            // Добавление playerLayer как sublayer к UIView
            self.view.layer.addSublayer(playerLayer)
            
            // Запуск видео
            player?.play()
        }
    }
    
}


extension MainCollectionViewController: MainCollectionViewProtocol {
    func updateData(with tasks: Tasks) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.taskName])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
}
