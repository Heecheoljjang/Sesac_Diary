//
//  SearchViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks == nil ? 0 : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.mainImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectID).jpg")
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.searchTextField.text?.lowercased() else { return }
        print(text)
        tasks = repository.fetchFilter(text)
        mainView.tableView.reloadData()
    }
}
