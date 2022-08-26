//
//  WriteView.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit
import SnapKit
import PhotosUI

final class WriteView: BaseView {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray

        return view
    }()
    
    let titleTextField: CustomTitleTextField = {
        let textField = CustomTitleTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        textField.tintColor = .white
        
        return textField
    }()
    
    let dateTextField: CustomDateTextField = {
        let textField = CustomDateTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "날짜를 선택해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        textField.tintColor = .clear
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(cancleDatePicker))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(selectDate))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        
        datePicker.maximumDate = Date()
        
        return datePicker
    }()
    
    let bodyTextView: CustomTextView = {
        let view = CustomTextView()
        
        view.attributedText = NSAttributedString(string: "내용을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        
        return view
    }()
    
    let imageSelectButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "photo")
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .systemGray
        configuration.cornerStyle = .capsule

        button.configuration = configuration
       
        return button
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
        super.configure()
        
        [mainImageView, titleTextField, dateTextField, bodyTextView, imageSelectButton, lineView].forEach {
            self.addSubview($0)
        }
        
        dateTextField.inputView = datePicker
                
        backgroundColor = .lightGray
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self).offset(24)
            make.trailing.equalTo(self).offset(-24)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mainImageView)
            make.height.equalTo(self).multipliedBy(0.06)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mainImageView)
            make.height.equalTo(self).multipliedBy(0.06)
        }
        
        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(mainImageView)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        imageSelectButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.trailing.equalTo(mainImageView.snp.trailing).offset(-20)
            make.bottom.equalTo(mainImageView.snp.bottom).offset(-20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(self)
        }
    }

    @objc func cancleDatePicker() {
        self.endEditing(true)
    }
    
    @objc func selectDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        formatter.locale = Locale(identifier: "ko-KR")
        
        let date = formatter.string(from: datePicker.date)
        dateTextField.text = date
        
        self.endEditing(true)
        
    }

}
