//
//  UserDiaryRepository.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/26.
//

import Foundation
import RealmSwift

//여러개의 테이블이 있따면 제네릭으로 선언해서 활용가능 UserDiary가 아니라 <T>로


protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchDate(date: String) -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
}

final class UserDiaryRepository: UserDiaryRepositoryType {

    let localRealm = try! Realm()
    
    func fetchDate(date: String) -> Results<UserDiary> {

        return localRealm.objects(UserDiary.self).filter("diaryDate == '\(date)'")
    }
    
    func addItem(item: UserDiary) {
        do {
            try localRealm.write {
                localRealm.add(item)
                print(localRealm.configuration.fileURL!)
            }
        } catch let error {
            print(error)
        }
    }

    //반환값 그대로
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func fetchFilter(_ filter: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryContent CONTAINS[c] '\(filter)'")
    }

    func updateFavorite(item: UserDiary) {
        try! localRealm.write {
            item.favorite = !item.favorite
        }
    }
    
    func deleteItem(item: UserDiary) {
        removeImageFromDocument(fileName: "\(item.objectID).jpg")
        try! localRealm.write {
            localRealm.delete(item)
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //document 경로까지 가져오는것
        let imageURL = documentDirectory.appendingPathComponent("images")
        let fileURL = imageURL.appendingPathComponent(fileName) //세부경로
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    private func stringToDate(_ stringDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        print("stringDate", stringDate)
        
        guard let date = dateFormatter.date(from: stringDate) else { return Date() }
        
        return date
    }
    
    private func dateToString(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date)
    }

}
