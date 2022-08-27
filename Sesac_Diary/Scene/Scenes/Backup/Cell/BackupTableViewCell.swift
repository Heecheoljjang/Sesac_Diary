//
//  BackupTableViewCell.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit
import SnapKit

class BackupTableViewCell: BaseTableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: BackupTableViewCell.identifier)
        
        configure()
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [dateLabel, nameLabel].forEach {
            self.addSubview($0)
        }
        backgroundColor = .lightGray
    }
    
    override func setUpContraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.top.equalTo(self).offset(12)
            make.height.equalTo(28)
            make.trailing.greaterThanOrEqualTo(self).offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.trailing.equalTo(dateLabel)
            make.height.equalTo(dateLabel)
            make.bottom.equalTo(self).offset(-12)
        }
    }
    
}
