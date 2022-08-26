//
//  UIViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/27.
//

import Foundation
import UIKit

extension UIViewController {
    
    func stringToDate(_ stringDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        guard let date = dateFormatter.date(from: stringDate) else { return Date() }
        
        return date
    }
    
    func dateToString(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date)
    }
}
