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
        
    }
}

extension WriteViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let vc = WritingTextViewController()
        
        vc.modalPresentationStyle = .fullScreen
        vc.bodyText = mainView.bodyTextView.text
        
        vc.sendTextHandler = { text in
            self.mainView.bodyTextView.text = text
        }
        
        present(vc, animated: true)
        return true
    }
    
}
