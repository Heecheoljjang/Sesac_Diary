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
    
    override func loadView() {
        self.view = mainView
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
    }
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
}

