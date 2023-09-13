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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func configure(with model: Movie) async {
        let baseURL = "https://image.tmdb.org/t/p/w400"
        
        guard let posterPath = model.posterPath else {
            self.imageView.image = UIImage(systemName: "photo")
            self.imageView.contentMode = .scaleAspectFit
            return
        }
        
        let stringURL = baseURL + posterPath
        self.imageView.setImageURL(stringURL)
    }

}
