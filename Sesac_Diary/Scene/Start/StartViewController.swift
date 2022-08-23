//
//  ViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit
import RealmSwift

class StartViewController: BaseViewController {

    var mainView = StartView()
    
    var diaryList: [Diary] = []
    
    let localRealm = try! Realm() //가져오기 2번쨰
    
    var tasks: Results<UserDiary>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        //object안에는 테이블이름.self
        //ascending은 오름내림차순(Bool), 기준이 key
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func fetchRealm() {
        //3. 정렬 후 tasks에 담기 -> 그대로 사용하는건 위험할 수도 있음.
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: false)
    }
    
    override func setUpNavigationController() {
        super.setUpNavigationController()
        
        let addButton = UIBarButtonItem(title: "글 쓰기", style: .plain, target: self, action: #selector(startWriting))
        let sortButton = UIBarButtonItem(title: "정렬", style: .done, target: self, action: #selector(sortList))
        let filterButton = UIBarButtonItem(title: "필터", style: .done, target: self, action: #selector(filterList))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItems = [sortButton, filterButton]
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
    
    @objc func sortList() {
        //더 다양하게 해보기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: true)
    }
    
    @objc func filterList() {
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'") //[c]쓰면 대소문자에 상관ㅇ벗이
    }

}

