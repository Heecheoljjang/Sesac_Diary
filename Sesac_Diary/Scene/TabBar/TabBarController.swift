//
//  TabBarController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    let startVC = StartViewController()
    let backupVC = BackupViewController()
    let searchVC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        configure()
    }
    
    func setUpViews() {
        
        startVC.title = "다이어리"
        backupVC.title = "설정"
        searchVC.title = "검색"
        
        let navStart = UINavigationController(rootViewController: startVC)
        let navBackup = UINavigationController(rootViewController: backupVC)
        let navSearch = UINavigationController(rootViewController: searchVC)

        setViewControllers([navStart, navSearch, navBackup], animated: true)
        
        //self.tabBar.selectedItem = tabBar.items?.first!
    }
    
    func configure() {

        tabBar.tintColor = .white
        
        startVC.tabBarItem.image = UIImage(systemName: "book.closed")
        backupVC.tabBarItem.image = UIImage(systemName: "gear")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
}
