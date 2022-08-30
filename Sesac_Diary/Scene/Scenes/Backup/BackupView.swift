//
//  BackupView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit
import SnapKit

final class BackupView: BaseView {

    let backupButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .lightGray
        configuration.baseBackgroundColor = .white
        configuration.title = "데이터 백업"
        configuration.cornerStyle = .medium
        button.configuration = configuration
        return button
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .lightGray
        configuration.baseBackgroundColor = .white
        configuration.title = "데이터 복구"
        configuration.cornerStyle = .medium
        button.configuration = configuration
        return button
    }()
    
    let backupTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.identifier)
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let secondLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
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
        
        [backupButton, restoreButton, backupTableView, lineView, secondLineView, tabBarLineView].forEach {
            self.addSubview($0)
        }
        
        backgroundColor = .lightGray
        
    }
    
    override func setUpConstraints() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(self)
            make.height.equalTo(1)
        }
        
        backupButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.height.equalTo(60)
            
            let width = UIScreen.main.bounds.width - 52
            make.width.equalTo(width / 2)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.leading.equalTo(backupButton.snp.trailing).offset(12)
            make.top.equalTo(backupButton)
            make.height.equalTo(backupButton)
            make.width.equalTo(backupButton)
        }
        
        backupTableView.snp.makeConstraints { make in
            make.top.equalTo(secondLineView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(tabBarLineView.snp.top)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(20)
            make.trailing.leading.equalTo(self)
            make.height.equalTo(1)
        }
        
        tabBarLineView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self)
            make.height.equalTo(1)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
