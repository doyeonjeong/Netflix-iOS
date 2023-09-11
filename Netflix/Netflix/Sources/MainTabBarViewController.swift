//
//  MainTabBarViewController.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/10.
//

import UIKit

struct TabBarItem {
    var title: String
    var imageName: String
}

extension TabBarItem {
    static let list: [TabBarItem] = [
        TabBarItem(title: "홈", imageName: "house.fill"),
        TabBarItem(title: "검색", imageName: "magnifyingglass"),
        TabBarItem(title: "공개예정", imageName: "play.rectangle.fill"),
        TabBarItem(title: "저장한 콘텐츠 목록", imageName: "square.and.arrow.down.fill"),
        TabBarItem(title: "더보기", imageName: "gear"),
    ]
}

class MainTabBarViewController: UITabBarController {
    
    private let animationView = AnimationLaunchScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension MainTabBarViewController {
    private func setup() {
        setAnimationSplashScreen()
    }
    
    private func setUI() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let upcomingVC = UINavigationController(rootViewController: UpcomingViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        let moreVC = UINavigationController(rootViewController: MoreViewController())
        
        let viewControllers = [homeVC, searchVC, upcomingVC, downloadVC, moreVC]
        configureTabBar(viewControllers)
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBar.isHidden = false
        setViewControllers(viewControllers, animated: false)
    }
    
    private func setAnimationSplashScreen() {
        view.addSubview(animationView)
        
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.alpha = 1
        
        animationView.play { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.animationView.alpha = 0
            }, completion: { _ in
                self.animationView.isHidden = true
                self.animationView.removeFromSuperview()
                self.setUI()
            })
        }
    }

    
}

extension MainTabBarViewController {
    
    private func configureTabBar(_ viewControllers: [UIViewController]) {
        for (vc, tabBarItem) in zip(viewControllers, TabBarItem.list) {
            vc.tabBarItem.title = tabBarItem.title
            vc.tabBarItem.image = UIImage(systemName: tabBarItem.imageName)
        }
    }
    
}
