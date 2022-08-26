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
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
}

class UserDiaryRepository {
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        
//        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) //%@는 NSPredicate로 매개변수로 생각
        //날짜를 고르면 00:00:00로 출력이되기때문에 그냥 date부터 86400더하면됨.
        return localRealm.objects(UserDiary.self).filter("registerDate >= %@ AND registerDate < %@", date, Date(timeInterval: 86400, since: date)) 
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
    
    let localRealm = try! Realm()
    
    //반환값 그대로
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true)
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
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부경로
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }

}