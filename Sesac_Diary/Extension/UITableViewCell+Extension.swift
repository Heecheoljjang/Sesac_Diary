//
//  UITableViewCell+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//
import UIKit

extension UITableViewCell: ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

