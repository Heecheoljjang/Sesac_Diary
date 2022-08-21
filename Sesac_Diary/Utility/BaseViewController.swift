//
//  BaseViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        configure()
    }
    
    func configure() {}
    
    func setUpNavigationController() {}
    
    func showAlert() {
        let alert = UIAlertController(title: "제목과 날짜는 반드시 작성해야합니다!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
