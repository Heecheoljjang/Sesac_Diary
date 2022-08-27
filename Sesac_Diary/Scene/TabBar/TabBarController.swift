//
//  TabBarController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    let startVC = StartViewController()
    let backupVC = BackupViewController()
    let searchVC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        setUpAppearance()
    }
    
    func setUpViews() {
        
        startVC.title = "다이어리"
        backupVC.title = "설정"
        searchVC.title = "검색"
        
        let navStart = UINavigationController(rootViewController: startVC)
        let navBackup = UINavigationController(rootViewController: backupVC)
        let navSearch = UINavigationController(rootViewController: searchVC)
        
        startVC.tabBarItem.image = UIImage(systemName: "book.closed")
        backupVC.tabBarItem.image = UIImage(systemName: "gear")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        setViewControllers([navStart, navSearch, navBackup], animated: true)
    }
    
    func setUpAppearance() {

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .lightGray
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .white
        
    }
}
