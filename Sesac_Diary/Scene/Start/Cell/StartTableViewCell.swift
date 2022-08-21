//
//  StartTableViewCell.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import UIKit

import SnapKit

class StartTableViewCell: BaseTableViewCell {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()
    
//    let dateLabel: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: StartTableViewCell.identifier)
        
        configure()
        
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        
        [mainImageView, titleLabel].forEach {
            self.addSubview($0)
        }
        backgroundColor = .lightGray
    }
    
    override func setUpContraints() {
        super.setUpContraints()
        
        mainImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
            make.bottom.equalTo(self).offset(-12)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(mainImageView.snp.centerY)
        }
    }
}
