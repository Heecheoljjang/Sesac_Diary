//
//  ImageSelectViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/21.
//

import UIKit

import JGProgressHUD
import Kingfisher

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageList[indexPath.item].regular)

        cell.imageView.kf.setImage(with: url)
        
        //보더
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.white.cgColor : nil
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        selectedImage = cell.imageView.image
        
        //보더
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
    
    //언제 실행되는지 찾아보기
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//        print("deselect", indexPath)
//        selectIndexPath = nil
//        selectedImage = nil
//        collectionView.reloadData()
//    }
    
}

extension ImageSelectViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if imageList.count - 3 == indexPath.item {
                page += 1
                if let text = mainView.searchBar.text {
                    fetchImage(page: page, query: text)
                }
            }
        }
    }
}

extension ImageSelectViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        mainView.collectionView.setContentOffset(.zero, animated: false)

        if let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let hud = JGProgressHUD()
            hud.textLabel.text = "Loading"
            hud.backgroundColor = .lightGray
            hud.show(in: self.mainView.collectionView)
            
            ImageAPIManager.shared.getImageUrl(page: page, query: text) { data in
                self.imageList = data
                
                self.mainView.collectionView.reloadData()
                
                hud.dismiss(animated: true)
            }
        }
    }
}
