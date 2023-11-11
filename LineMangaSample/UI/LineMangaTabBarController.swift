//
//  LinMangaTabBarController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/10.
//

import UIKit

final class LineMangaTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.tabBar.tintColor = .black
    }
    
    private func configure() {
        let recommendationVC = UINavigationController(rootViewController: RecommendationViewController())
        recommendationVC.tabBarItem = UITabBarItem(title: "おすすめ", image: UIImage(systemName: "star.bubble.fill"), tag: 0)
        
        let rankingVC = UINavigationController(rootViewController: RankingViewController())
        rankingVC.tabBarItem = UITabBarItem(title: "ランキング", image: UIImage(systemName: "trophy.fill"), tag: 1)
        
        self.viewControllers = [recommendationVC, rankingVC]
    }
}
