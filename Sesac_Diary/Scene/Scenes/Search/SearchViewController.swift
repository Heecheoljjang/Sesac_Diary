//
//  SearchViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import UIKit
import RealmSwift

class SearchViewController: BaseViewController {
    
    var mainView = SearchView()
    
    let repository = UserDiaryRepository()
    
    var tasks: Results<UserDiary>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        
        setUpTableView()
        
        //tasks = repository.fetch()
    }
    
    override func setUpNavigationController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [.foregroundColor: UIColor.white])
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
    
    func setUpTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    

}
