//
//  SearchViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
