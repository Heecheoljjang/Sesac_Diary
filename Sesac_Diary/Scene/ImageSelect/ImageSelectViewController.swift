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
    
    var page: Int = 1
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.delegate = self
                
        setUpCollectionView()
                    
    }
    
    func setUpCollectionView() {
        mainView.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
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

