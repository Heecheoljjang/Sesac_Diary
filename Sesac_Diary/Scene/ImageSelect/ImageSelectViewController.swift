//
//  ImageSelectViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class ImageSelectViewController: BaseViewController {
    
    var mainView = ImageSelectView()
    
    var imageList: [ImageSearchModel] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageAPIManager.shared.getImageUrl(page: 1, query: "desk") { value in
            self.imageList = value
            
            //mainView.collectionView.reloadData()
        }
            
    }
    
    override func setUpNavigationController() {
        super.setUpNavigationController()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneSelection))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        title = "이미지 선택하기"
    }
    
    @objc func doneSelection() {
        
        //데이터 전달
        
        //화면 내리기
        navigationController?.popViewController(animated: true)
    }
}
