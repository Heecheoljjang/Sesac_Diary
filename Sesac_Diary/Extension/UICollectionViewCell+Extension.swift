//
//  UICollectionViewCell+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/21.
//
import UIKit

protocol ReuseIdentifier {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
