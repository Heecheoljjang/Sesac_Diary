//
//  ImageSelectViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

import JGProgressHUD

final class ImageSelectViewController: BaseViewController {
    
    var mainView = ImageSelectView()
    
    var imageList: [ImageSearchModel] = []
    
    var page: Int = 1
    
    var selectedImage: UIImage?
    
    var imageHandler: ((UIImage) -> ())?
    
    var delegate: SelectImageDelegate?
    
    var selectIndexPath: IndexPath?
    
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
        mainView.collectionView.prefetchDataSource = self

    }
    
    func fetchImage(page: Int, query: String) {
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.backgroundColor = .lightGray
        hud.show(in: self.mainView.collectionView)
        
        if let text = mainView.searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            ImageAPIManager.shared.getImageUrl(page: page, query: text) { data in
                self.imageList.append(contentsOf: data)
                
                self.mainView.collectionView.reloadData()
                
                hud.dismiss(animated: true)
            }
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
        if let image = selectedImage {
//            imageHandler?(image)
            delegate?.sendImageDate(image: image)
        }
        
        //화면 내리기
        transition(self, transitionSytle: .pop)
        //navigationController?.popViewController(animated: true)
    }
}

