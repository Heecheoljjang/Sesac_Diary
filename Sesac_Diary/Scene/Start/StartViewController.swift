//
//  ViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class StartViewController: BaseViewController {

    var mainView = StartView()
    
    var diaryList: [Diary] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(diaryList.count)
        mainView.tableView.reloadData()
    }
    
    override func setUpNavigationController() {
        super.setUpNavigationController()
        
        let addButton = UIBarButtonItem(title: "글 쓰기", style: .plain, target: self, action: #selector(startWriting))
        self.navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        title = "내 다이어리"
    }
    
    func setUpTableView() {
        mainView.tableView.register(StartTableViewCell.self, forCellReuseIdentifier: StartTableViewCell.identifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self

    }

    @objc func startWriting() {
        let vc = WriteViewController()
        vc.diaryDataHandler = { diary in
            self.diaryList.append(diary)
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

