//
//  RealmModel.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import Foundation
import RealmSwift
import UIKit

//테이블에 대한 스키마
//테이블 이름
//@persisted: 컬럼
class UserDiary: Object {
    //제목, 내용(옵션), 작성날짜(필), 등록 날짜(필), 즐겨찾기(필), 사진url(옵)
    @Persisted var diaryTitle: String //제목(필수)
    @Persisted var diaryContent: String?
    @Persisted var diaryDate: String
    @Persisted var registerDate = Date()
    @Persisted var favorite: Bool = false
    
    //PK(필수): Int, UUID, ObjectID
    //Int를 사용하면 직접 1씩 더하면서 직접 지정해야하는데, 뒤의 두개는 중복안되게 알아서 정해줌. 차이는 UUID는 16, object는 12바이트
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: String, registerDate: Date) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.registerDate = registerDate
    }
}
