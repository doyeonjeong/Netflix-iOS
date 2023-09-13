//
//  HomeViewController.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/07.
//

import UIKit

typealias Item = Movie
typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

enum Section: Int, CaseIterable, Hashable {
    case header = 0
    case daily = 1
    case newKR = 2
    case newUS = 3
}

class HomeViewController: UIViewController {
    
    let sectionTitles = ["", "일별 박스오피스", "한국 최신영화", "미국 최신영화"]
    
    var mainItem = [Movie]()
    var dailyMovies = [Movie]()
    var newKRMovies = [Movie]()
    var newUSMovies = [Movie]()
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    var selectedMovieId = 976573 // 엘리멘탈 -> Int? 형으로 바꾸고 사용자가 셀을 선택했을 때 변경되도록 해야함
    
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
        configureDataSource()
        configureSnapshot()
        addSubviews()
        setConstraints()
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

// MARK: - Setup data
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
                    
                case .daily:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UICollectionViewCell() }
                    Task {
                        await cell.configure(with: item)
                    }
                    return cell
                    
                case .newKR:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UICollectionViewCell() }
                    Task {
                        await cell.configure(with: item)
                    }
                    return cell
                    
                case .newUS:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UICollectionViewCell() }
                    Task {
                        await cell.configure(with: item)
                    }
                    return cell
                }
            }
        )
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <SectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            supplementaryView.sectionTitleLabel.text = self.sectionTitles[indexPath.section]
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
    }
    
    private func configureSnapshot() {
        snapshot.appendSections(Section.allCases)
//        getMainItem()
        fetchDailyMovies()
        fetchNewKRMovies()
        fetchNewUSMovies()
    }
    
}

// MARK: - Setup Layout
extension HomeViewController {
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.68))
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
    
}

// MARK: - APICall & FetchData
extension HomeViewController {
    
    private func appendDailySnapshot(_ movies: [Movie]) {
        
        guard var dailyItem = movies.randomElement() else {
            return
        }
        dailyItem.isMainItem = true
        mainItem = [dailyItem]
        snapshot.appendItems(mainItem, toSection: .header)
        snapshot.appendItems(movies, toSection: .daily)
        dataSource.apply(snapshot)
    }
    
    private func appendNewKRSnapshot(_ movies: [Movie]) {
        snapshot.appendItems(movies, toSection: .newKR)
        dataSource.apply(snapshot)
    }
    
    private func appendNewUSSnapshot(_ movies: [Movie]) {
        snapshot.appendItems(movies, toSection: .newUS)
        dataSource.apply(snapshot)
    }
    
    private func fetchDailyMovies() {
        APICaller.shared.getDailyBoxOfficeMovies { [weak self] results in
            switch results {
            case .success(let movies):
                self?.dailyMovies = movies
                self?.appendDailySnapshot(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchNewKRMovies() {
        APICaller.shared.getNewKoreaMovies { [weak self] results in
            switch results {
            case .success(let movies):
                self?.newKRMovies = movies
                self?.appendNewKRSnapshot(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchNewUSMovies() {
        APICaller.shared.getNewUSAMovies { [weak self] results in
            switch results {
            case .success(let movies):
                self?.newUSMovies = movies
                self?.appendNewUSSnapshot(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
