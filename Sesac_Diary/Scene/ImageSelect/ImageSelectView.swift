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
        
        return bar
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
        
        [searchBar, lineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(self)
        }
    }
}
