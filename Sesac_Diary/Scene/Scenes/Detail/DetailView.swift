//
//  DetailView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let bodyTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        view.textColor = .white
        view.isEditable = false
        view.layer.cornerRadius = 10
                
        return view
    }()
    
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
        [dateLabel, mainImageView, bodyTextView, lineView].forEach {
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
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(24)
            make.top.equalTo(lineView.snp.bottom).offset(12)
            
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(24)
            make.trailing.equalTo(self).offset(-24)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mainImageView)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        
    }
}
