//
//  ViewController.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/07.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "animation_netflix")
        lottieAnimationView.backgroundColor = .black
        return lottieAnimationView
    }()
    
    lazy var helloWorldLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
extension ViewController {
    
    private func setup() {
        setUI()
        addSubviews()
        setAnimationSplashScreen()
    }
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(animationView)
        view.addSubview(helloWorldLabel)
    }
    
    private func setAnimationSplashScreen() {
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.alpha = 1
        
        animationView.play { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.animationView.alpha = 0
            }, completion: { _ in
                self.animationView.isHidden = true
                self.animationView.removeFromSuperview()
                self.setConstraints()
            })
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
