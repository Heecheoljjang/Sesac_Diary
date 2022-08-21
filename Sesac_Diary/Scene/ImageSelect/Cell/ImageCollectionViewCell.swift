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
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                imageView.layer.borderColor = UIColor.white.cgColor
            }
            else {
                imageView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
        
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
