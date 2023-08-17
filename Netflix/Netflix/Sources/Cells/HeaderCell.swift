//
//  HeaderCell.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/11.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("▶︎  재생", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addButton, playButton, infoButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = -40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

// MARK: - Setup
extension HeaderCell {
    
    private func setup() {
        addSubviews()
        configureViews()
    }
    
    private func addSubviews() {
        contentView.addSubview(backgroundStackView)
    }
    
    private func configureViews() {
        NSLayoutConstraint.activate([
            backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
}

extension HeaderCell {
    
    func configure(_ item: Item) {
        imageView.image = UIImage(systemName: item.imageName)
    }
    
}

extension HeaderCell {
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func playButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func infoButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
}
