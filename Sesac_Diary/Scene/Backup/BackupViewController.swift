//
//  BackupViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

class BackupViewController: BaseViewController {
    
    var mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        
        mainView.backupTableView.delegate = self
        mainView.backupTableView.dataSource = self
    }
    
    override func setUpNavigationController() {
//        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissView))
       // navigationItem.leftBarButtonItem = dismissButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        title = "데이터 백업 및 복구"
    }
    
    @objc func dismissView() {
        transition(self, transitionSytle: .pop)
    }
}
