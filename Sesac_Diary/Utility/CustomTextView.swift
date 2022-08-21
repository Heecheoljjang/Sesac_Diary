//
//  CustomTextView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        textColor = .white.withAlphaComponent(0.6)
        layer.cornerRadius = 10
        //font = .systemFont(ofSize: 18, weight: .regular)
        textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        backgroundColor = .systemGray
    }
}

