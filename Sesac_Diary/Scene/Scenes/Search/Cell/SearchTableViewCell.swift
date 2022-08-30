//
//  SearchTableViewCell.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 4
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SearchTableViewCell.identifier)
        
        configure()
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        
        [mainImageView, titleLabel].forEach {
            self.addSubview($0)
        }
        backgroundColor = .lightGray
        
    }
    
    override func setUpContraints() {
        
        mainImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(12)
//            make.top.equalTo(self).offset(12)
//            make.bottom.equalTo(self).offset(-12)
            make.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(mainImageView)
            make.height.equalTo(mainImageView).multipliedBy(0.4)
        }
        
    }
    
}
