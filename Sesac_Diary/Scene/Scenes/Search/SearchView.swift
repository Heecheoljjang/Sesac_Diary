//
//  SearchView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let tabBarLineView: UIView = {
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
        
        [tabBarLineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpConstraints() {
        tabBarLineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.leading.trailing.equalTo(self)
        }
    }
    
}
