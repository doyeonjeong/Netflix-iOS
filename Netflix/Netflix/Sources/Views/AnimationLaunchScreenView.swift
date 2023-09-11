//
//  AnimationLaunchScreenView.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/10.
//

import UIKit
import Lottie

final class AnimationLaunchScreenView: UIView {
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "animation_netflix")
        lottieAnimationView.backgroundColor = .black
        return lottieAnimationView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnimationLaunchScreenView {
    
    private func setup() {
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = bounds
        animationView.center = center
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func play(completion: @escaping (Bool) -> Void) {
        animationView.play(completion: completion)
    }
    
}
