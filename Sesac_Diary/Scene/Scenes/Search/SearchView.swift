//
//  SearchView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import UIKit
import SnapKit
import MapKit

final class SearchView: BaseView {
    
    let tabBarLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return view
    }()
    
    let searchBarLineView: UIView = {
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
        
        [tabBarLineView, tableView, searchBarLineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpConstraints() {
        tabBarLineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.leading.trailing.equalTo(self)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(tabBarLineView.snp.top)
            make.top.equalTo(searchBarLineView.snp.bottom)
        }
        
        searchBarLineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
}
