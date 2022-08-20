//
//  WriteViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
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

//    func textViewDidEndEditing(_ textView: UITextView) {
//
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
    @objc func keyboardWillChange(_ sender: Notification) {
        
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height

        if mainView.frame.origin.y == 0 {
            mainView.frame.origin.y = -keyboardHeight
        }
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        mainView.frame.origin.y = 0 // 다시 원상복구
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
