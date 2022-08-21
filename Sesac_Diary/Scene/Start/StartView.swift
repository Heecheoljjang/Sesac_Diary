//
//  StartView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

import SnapKit

class StartView: BaseView {

    let lineView: UIView = {
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
        
        [lineView].forEach {
            self.addSubview($0)
        }
        backgroundColor = .lightGray
    }
    
    override func setUpConstraints() {
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(self)
        }
    }

}
