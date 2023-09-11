//
//  MovieDetailViewController.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieId: Int = 0
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉일"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "별점"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var releaseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingLabel, ratingStarStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("▶︎  재생", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal)
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "장르"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genresLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var genreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel, UIView(), genresLabelStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playButton, downloadButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, buttonStackView, releaseStackView, ratingStackView, genreStackView, overviewLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension MovieDetailViewController {
    
    private func setup() {
        setBackgroundColor()
        addSubviews()
        setConstraints()
        fetchData()
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(backgroundStackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backgroundStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            releaseStackView.heightAnchor.constraint(equalToConstant: 60),
            genreStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonStackView.heightAnchor.constraint(equalToConstant: 80),
            ratingStarStackView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }
    
    private func fetchData() {
        APICaller.shared.getDetailAMovieInfomations(id: movieId) { [weak self] result in
                switch result {
                case .success(let movieDetail):
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        Task {
                            await self.configure(with: movieDetail)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}

extension MovieDetailViewController {
    
    func configure(with model: MovieDetailResponse) async {
        
        setImage(model.backdropPath)
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        releaseDateLabel.text = model.releaseDate
        
        let ratingStars = convertRatingToStars(rating: model.voteAverage)
        configureRatingStars(fullStars: ratingStars.0, halfStar: ratingStars.1, maxStars: 5)
        
        configureGenres(with: model.genres)
    }
    
    private func setImage(_ path: String?) {
        
        let baseURL = "https://image.tmdb.org/t/p/w400"
        guard let backdropPath = path else { return }
        let stringURL = baseURL + backdropPath
        
        if let cacheImage = CacheManager.shared.object(forKey: stringURL as NSString) {
            self.imageView.image = cacheImage
            return
        }
        
        DispatchQueue.global().async {
            guard
                let url = URL(string: stringURL),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                CacheManager.shared.setObject(image, forKey: stringURL as NSString)
                self.imageView.image = image
            }
        }
    }
    
    private func convertRatingToStars(rating: Double) -> (Int, Bool) {
        let fullStars = Int(rating / 2)
        let halfStar = rating.truncatingRemainder(dividingBy: 2) >= 0.5
        return (fullStars, halfStar)
    }

    private func configureGenres(with genres: [Genre]) {
        genresLabelStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for genre in genres {
            if let genreName = genre.name {
                let label = UILabel()
                label.text = genreName
                label.font = .systemFont(ofSize: 14)
                label.textColor = .white
                genresLabelStackView.addArrangedSubview(label)
            }
        }
    }
    
    func configureRatingStars(fullStars: Int, halfStar: Bool, maxStars: Int = 5) {
        ratingStarStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<fullStars {
            let filledStarImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            ratingStarStackView.addArrangedSubview(filledStarImageView)
        }
        
        if halfStar {
            let halfStarImageView = UIImageView(image: UIImage(systemName: "star.fill.left"))
            ratingStarStackView.addArrangedSubview(halfStarImageView)
        }
        
        let emptyStars = maxStars - fullStars - (halfStar ? 1 : 0)
        for _ in 0..<emptyStars {
            let emptyStarImageView = UIImageView(image: UIImage(systemName: "star"))
            ratingStarStackView.addArrangedSubview(emptyStarImageView)
        }
    }

}

extension MovieDetailViewController {
    
    @objc private func playButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func downloadButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
}
