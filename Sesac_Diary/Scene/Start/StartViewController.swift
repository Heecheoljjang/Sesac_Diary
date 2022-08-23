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
        
        setUpButton()
        
        //object안에는 테이블이름.self
        //ascending은 오름내림차순(Bool), 기준이 key
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func setUpButton() {
        let menus: [UIAction] = [
            UIAction(title: "제목순", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                self.tasks = self.localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
                self.mainView.tableView.reloadData()
            }), UIAction(title: "날짜순", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                self.tasks = self.localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
                self.mainView.tableView.reloadData()
            })
        ]
        
        let sortButtonMenu = UIMenu(title: "정렬", image: nil, identifier: nil, options: .displayInline, children: menus)
        let sortButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "line.3.horizontal.circle"), primaryAction: nil, menu: sortButtonMenu)
        navigationItem.leftBarButtonItem = sortButton
        
        let addButton = UIBarButtonItem(title: "글 쓰기", style: .plain, target: self, action: #selector(startWriting))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func fetchRealm() {
        //3. 정렬 후 tasks에 담기 -> 그대로 사용하는건 위험할 수도 있음.
        tasks = localRealm.objects(UserDiary.self)
    }
    
    override func setUpNavigationController() {
        super.setUpNavigationController()
        
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

