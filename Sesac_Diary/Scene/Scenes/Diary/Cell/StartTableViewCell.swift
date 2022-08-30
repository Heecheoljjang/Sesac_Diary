//
//  StartTableViewCell.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import UIKit

import SnapKit

final class StartTableViewCell: BaseTableViewCell {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

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
        
        [mainImageView, titleLabel, dateLabel].forEach {
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
            make.width.equalTo(76)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.top.equalTo(mainImageView.snp.top)
            make.height.equalTo(mainImageView).multipliedBy(0.4)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(mainImageView.snp.bottom)
            make.height.equalTo(mainImageView).multipliedBy(0.2)
        }
        
    }
}
