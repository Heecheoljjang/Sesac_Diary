//
//  BackupViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

extension BackupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.identifier) as? BackupTableViewCell else { return UITableViewCell() }
        
        cell.dateLabel.text = backupArray[indexPath.row]
        cell.nameLabel.text = "Diary_\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //백업 파일 지우기
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            self.removeFile(self.backupArray[indexPath.row])
            
            self.backupArray = self.fetchDocumentZipFile().map { "\($0.split(separator: ".")[0])" }
            
            self.mainView.backupTableView.reloadData()
        }
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
