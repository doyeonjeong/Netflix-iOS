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
    
    let mainItem = Movie.getMainItem()
    let dailyItems = Movie.daily
    let newKRItems = Movie.newKR
    let newUSItems = Movie.newUS
    
    private var dataSource: DataSource!
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
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
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                
                guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
                
                switch section {
                    
                case .header:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as? HeaderCell else { return UICollectionViewCell() }
                    cell.configure(item)
                    return cell
                    
                case .daily, .newKR, .newUS:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UICollectionViewCell() }
                    cell.configure(item)
                    return cell
                }
                
            }
        )
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <SectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            supplementaryView.configure(Movie(title: "1", imageName: "2", category: "category"))
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mainItem, toSection: .header)
        snapshot.appendItems(dailyItems, toSection: .daily)
        snapshot.appendItems(newKRItems, toSection: .newKR)
        snapshot.appendItems(newUSItems, toSection: .newUS)
        dataSource.apply(snapshot)
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionNumber) else { return nil }
            
            switch section {
            case .header:
                return self?.createHeaderSectionLayout()
            case .daily, .newKR, .newUS:
                return self?.createMovieListSectionLayout()
            }
            
        }
    }
    
    private func createHeaderSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }
    
    private func createMovieListSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(30)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        return sectionHeader
    }
    
    private func getMainItem(_ items: [Movie]) -> Movie? {
        guard var item = items.randomElement() else {
            return nil
        }
        item.category = "recommendation"
        return item
    }

}
