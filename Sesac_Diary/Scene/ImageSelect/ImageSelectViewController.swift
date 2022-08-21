//
//  ImageSelectViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class ImageSelectViewController: BaseViewController {
    
    var mainView = ImageSelectView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageAPIManager.shared.getImageUrl(page: 1, query: "hee") { value in
            
        }
        
    }
}
