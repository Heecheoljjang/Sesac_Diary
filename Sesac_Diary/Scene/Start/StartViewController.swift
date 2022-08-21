//
//  ViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class StartViewController: BaseViewController {

    var mainView = StartView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(title: "글 쓰기", style: .plain, target: self, action: #selector(startWriting))
        
        self.navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc func startWriting() {
        let vc = WriteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

