//
//  ImageCollectionViewCell.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/21.
//

import UIKit

import SnapKit

class ImageCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.addSubview(imageView)
    }
    
    override func setUpContraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
