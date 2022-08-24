//
//  BackupViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

extension BackupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.identifier) as? BackupTableViewCell else { return UITableViewCell() }
        
        cell.dateLabel.text = "Date"
        cell.nameLabel.text = "Name"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
