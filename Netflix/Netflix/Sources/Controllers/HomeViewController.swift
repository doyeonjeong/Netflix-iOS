//
//  HomeViewController.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/07.
//

import UIKit

typealias Item = Movie
typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

enum Section: Int, CaseIterable {
    case header
    case daily
    case newKR
    case newUS
}

class HomeViewController: UIViewController {
    
    let items = Movie.list
    
    private var dataSource: DataSource!
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.backgroundColor = .black
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension HomeViewController {
    
    private func setup() {
        setBackgroundColor()
        addSubviews()
        setConstraints()
        configureDataSource()
        configureSnapshot()
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
}

extension HomeViewController {
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }

    
    private func configureDataSource() {
        
    }
    
    private func configureSnapshot() {
        
    }
    
}
