//
//  ImageSelectViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/21.
//

import UIKit

import JGProgressHUD

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageList[indexPath.item].regular)
        let data = try! Data(contentsOf: url!)
        let image = UIImage(data: data)
        cell.imageView.image = image
        
        return cell
    }
}

extension ImageSelectViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.backgroundColor = .lightGray
        hud.show(in: self.mainView.collectionView)
        
        if let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            ImageAPIManager.shared.getImageUrl(page: page, query: text) { data in
                self.imageList = data
                
                self.mainView.collectionView.reloadData()
                
                hud.dismiss(animated: true)
            }
        }
    }
}
