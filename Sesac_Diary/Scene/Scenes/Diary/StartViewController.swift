//
//  ViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit
import RealmSwift
import FSCalendar

class StartViewController: BaseViewController {

    var mainView = StartView()
    
    var diaryList: [Diary] = []
    
    let repository = UserDiaryRepository()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
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

        setUpCalendar()
        
        createImageDirectory()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //fetchRealm()
        let dateText = dateToString(Date())
        print("dateText", dateText)
        tasks = repository.fetchDate(date: dateText)
        mainView.calendar.reloadData()
        mainView.tableView.reloadData()
    }
    
    func setUpButton() {
        let menus: [UIAction] = [
            UIAction(title: "제목순", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                self.tasks = self.repository.fetchSort(tasks: self.tasks, "diaryTitle")
                self.mainView.tableView.reloadData()
            }), UIAction(title: "날짜순", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                self.tasks = self.repository.fetchSort(tasks: self.tasks, "diaryDate")
                self.mainView.tableView.reloadData()
            })
        ]
        
        let sortButtonMenu = UIMenu(title: "정렬", image: nil, identifier: nil, options: .displayInline, children: menus)
        let sortButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "line.3.horizontal.circle"), primaryAction: nil, menu: sortButtonMenu)

        navigationItem.leftBarButtonItem = sortButton
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(startWriting))
        
        self.navigationItem.rightBarButtonItems = [addButton]
    }
    
    func fetchRealm() {
        //3. 정렬 후 tasks에 담기 -> 그대로 사용하는건 위험할 수도 있음.
        //tasks = localRealm.objects(UserDiary.self)
        tasks = repository.fetch() //레포지토리 사용
    }
    
    override func setUpNavigationController() {
        super.setUpNavigationController()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
    }
    
    func setUpTableView() {
        mainView.tableView.register(StartTableViewCell.self, forCellReuseIdentifier: StartTableViewCell.identifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self

    }
    
    func setUpCalendar() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }

    @objc func startWriting() {
        let vc = WriteViewController()
        vc.diaryDataHandler = { diary in
            self.diaryList.append(diary)
            
        }
        transition(vc, transitionSytle: .push)
    }
    
    @objc func presentBackupView() {
        let vc = BackupViewController()
     
        transition(vc, transitionSytle: .push)
    }
}

