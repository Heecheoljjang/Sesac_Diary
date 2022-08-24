//
//  FileManager+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //document 경로까지 가져오는것
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부경로
        // url에 이미지가 존재하는지 확인 후 없으면 기본이미지
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return nil
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //document 경로까지 가져오는것
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부경로
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //document 경로까지 가져오는것
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부경로. 즉, /Documents/fileName 이미지를 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //압축
        
        do {
            try data.write(to: fileURL) // try 저장될때가지 쭉 시도함 -> 다른 코드들보다 우선순위 두는 느낌
        } catch let error {
            print("저장 실패", error)
        }
    }
}
