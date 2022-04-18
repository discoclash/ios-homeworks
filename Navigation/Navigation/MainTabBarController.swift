//
//  MainTabBarController.swift
//  Navigation
//
//  Created by G on 13.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let feed = FeedViewController()
    let profile = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        
        let profileNC = UINavigationController(rootViewController: profile)
        profile.tabBarItem.title = "Профиль"
        profile.tabBarItem.image = UIImage (systemName: "person.crop.circle.fill")
        profile.navigationItem.title = "ВАШ ПРОФИЛЬ"
        
        let feedNC = UINavigationController(rootViewController: feed)
        feed.tabBarItem.title = "Новости"
        feed.tabBarItem.image = UIImage (systemName: "newspaper")
        feed.navigationItem.title = "ВАША ЛЕНТА"
        
        viewControllers = [feedNC, profileNC]
    }
}
