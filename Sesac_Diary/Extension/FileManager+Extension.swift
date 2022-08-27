//
//  FileManager+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //document 경로까지 가져오는것
        
        return documentDirectory
    }
    
    func createImageDirectory() {
        guard let documnetDirectory = documentDirectoryPath() else { return }
        
        let imageDirectoryURL = documnetDirectory.appendingPathComponent("images")
        
        if !FileManager.default.fileExists(atPath: imageDirectoryURL.path) {
            do {
                try FileManager.default.createDirectory(atPath: imageDirectoryURL.path, withIntermediateDirectories: true)
            } catch let error {
                print(error)
            }
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //document 경로까지 가져오는것
        let imageDirectory = documentDirectory.appendingPathComponent("images")
        let fileURL = imageDirectory.appendingPathComponent(fileName) //세부경로
        // url에 이미지가 존재하는지 확인 후 없으면 기본이미지
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return nil
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //document 경로까지 가져오는것
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images")
        let imageURL = imageDirectoryURL.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //압축
        
        //이미지폴더는 있는 상태
        //이미지 저장
        do {
            try data.write(to: imageURL)
        } catch let error {
            print(error)
        }
    }
    
    func fetchDocumentZipFile() -> [String] {
        //zip파일 가져오기
        do {
            guard let path = documentDirectoryPath() else { return [] }
            
            //including~~에선 추가적인 정보를 얻을 수 이씅ㅁ.
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            //docs중 zip파일만 필터링
            let zip = docs.filter {
                $0.pathExtension == "zip" //pathExtension은 확장자를 의미. 스트링의 contain으로도 가능
            }
            print("zip: \(zip)")
            
            //지금 출력하면 전체 경로가 출력돼ㅑ서 지저분
            let result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            
            return result
            
        } catch {
            print("error")
        }
        return []
    }
    
    func removeFile(_ item: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(item + ".zip")
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("완료")
        } catch let error {
            print(error)
        }
    }
}
