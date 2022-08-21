//
//  StartViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import UIKit

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StartTableViewCell.identifier) as? StartTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = diaryList[indexPath.row].title
        if diaryList[indexPath.row].image != nil {
            cell.mainImageView.image = diaryList[indexPath.row].image!
        } else {
            cell.mainImageView.backgroundColor = .systemGray4
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}
