//
//  MovieCell.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/09.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

// MARK: - Setup
extension MovieCell {
    
    private func setup() {
        addSubviews()
        configureViews()
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func configureViews() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - Action
extension MovieCell {
    
    func configure(_ item: Item) {
        imageView.image = UIImage(systemName: item.imageName)
    }
    
}
