//
//  SectionTitleView.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/16.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
        
    lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

extension SectionHeaderView {
    
    private func setup() {
        addSubviews()
        configureViews()
    }
    
    private func addSubviews() {
        addSubview(sectionTitleLabel)
    }
    
    private func configureViews() {
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}

extension SectionHeaderView {
    
    func configure(_ item: Item) {
        sectionTitleLabel.text = item.category
    }
    
}
