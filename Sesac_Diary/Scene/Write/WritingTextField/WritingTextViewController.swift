//
//  WritingTextViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class WritingTextViewController: BaseViewController {
    
    var mainView = WritingTextFieldView()
    
    var bodyText = ""
    
    var sendTextHandler: ((String) -> ())?
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mainTextView.text = bodyText
        mainView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(sendText), for: .touchUpInside)
    }
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
    
    @objc func sendText() {
        sendTextHandler?(mainView.mainTextView.text)
        dismiss(animated: true)
    }
}

