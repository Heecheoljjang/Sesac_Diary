//
//  WriteViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

//1. 임포트
import RealmSwift

class WriteViewController: BaseViewController {

    var mainView = WriteView()
    
    //2. realm테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근을 하기위한 코드
    let localRealm = try! Realm() //
    
    var diaryDataHandler: ((Diary) -> ())?
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.bodyTextView.delegate = self
        mainView.dateTextField.delegate = self
        mainView.titleTextField.delegate = self
        
        let mainViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        let imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        
        mainView.addGestureRecognizer(mainViewTapGesture)
        mainView.mainImageView.addGestureRecognizer(imageViewTapGesture)
        
        mainView.imageSelectButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
                
    }

    override func setUpNavigationController() {
        super.setUpNavigationController()
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneWriting))
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]

        title = "글 쓰기"
    }
    
    @objc func doneWriting() {
        //데이터 전달
        //데이터 다 있는지
        if mainView.titleTextField.text != "" && mainView.dateTextField.text != "" {
            if mainView.bodyTextView.text != "내용을 입력해주세요" {
//                let diary = Diary(image: mainView.mainImageView.image, title: mainView.titleTextField.text!, date: mainView.dateTextField.text!, body: mainView.bodyTextView.text)
//                diaryDataHandler?(diary)
                
                //이미지 스트링으로
                let data = mainView.mainImageView.image?.pngData()?.base64EncodedString(options: .endLineWithLineFeed)
                let task = UserDiary(diaryTitle: mainView.titleTextField.text!, diaryContent: mainView.bodyTextView.text, diaryDate: mainView.dateTextField.text!, registerDate: Date(), imageString: data)
                
                try! localRealm.write {
                    localRealm.add(task)
                    print(localRealm.configuration.fileURL!)
                }
                
                //pop
                navigationController?.popViewController(animated: true)
            } else {
//                let diary = Diary(image: mainView.mainImageView.image, title: mainView.titleTextField.text!, date: mainView.dateTextField.text!, body: "")
//                diaryDataHandler?(diary)
                //이미지 스트링으로
                let data = mainView.mainImageView.image?.pngData()?.base64EncodedString(options: .endLineWithLineFeed)
                let task = UserDiary(diaryTitle: mainView.titleTextField.text!, diaryContent: "", diaryDate: mainView.dateTextField.text!, registerDate: Date(), imageString: data)
                
                try! localRealm.write {
                    localRealm.add(task)
                }
                //pop
                navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert()
        }
    }
  
    @objc func selectImage() {
        let vc = ImageSelectViewController()
        vc.imageHandler = { image in
            self.mainView.mainImageView.image = image
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        mainView.bodyTextView.endEditing(true)
        mainView.titleTextField.endEditing(true)
        mainView.dateTextField.endEditing(true)
    }
    
}

extension WriteViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        mainView.dateTextField.endEditing(true)
        mainView.titleTextField.endEditing(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .white.withAlphaComponent(0.6) {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "내용을 입력해주세요"
            textView.textColor = .white.withAlphaComponent(0.6)
        }
    }

    @objc func keyboardWillChange(_ sender: Notification) {
        
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height

        if navigationController?.view.frame.origin.y == 0 {
            navigationController?.view.frame.origin.y = -keyboardHeight
        }
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        navigationController?.view.frame.origin.y = 0
    }
}

extension WriteViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == mainView.titleTextField {
            mainView.dateTextField.endEditing(true)
        } else {
            mainView.titleTextField.endEditing(true)
        }
        mainView.bodyTextView.endEditing(true)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
