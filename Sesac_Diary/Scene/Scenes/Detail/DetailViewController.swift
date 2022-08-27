//
//  DetailViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var mainView = DetailView()
    
    var diary: Diary?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let diary = diary {
            mainView.bodyTextView.text = diary.body
            mainView.dateLabel.text = diary.date
            mainView.mainImageView.image = loadImageFromDocument(fileName: diary.image!)
        }
        
    }
    
    override func setUpNavigationController() {
        
        //타이틀을 제목으로
        title = diary?.title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
