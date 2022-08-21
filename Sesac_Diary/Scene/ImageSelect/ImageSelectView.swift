//
//  ImageSelectView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

import SnapKit

class ImageSelectView: BaseView {
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.barTintColor = .lightGray
        bar.searchTextField.backgroundColor = .white
        bar.searchBarStyle = .minimal
        bar.searchTextField.textColor = .systemGray

        return bar
    }()
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = .lightGray
        view.allowsMultipleSelection = false
        
        return view
    }()
    
    let secondLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        backgroundColor = .lightGray
        
        [searchBar, lineView, collectionView, secondLineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(60)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(secondLineView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.leading.equalTo(self)
        }
    }
}
