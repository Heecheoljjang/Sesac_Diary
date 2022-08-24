//
//  StartViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import UIKit
import RealmSwift // 1. 임포트
import SwiftUI

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StartTableViewCell.identifier) as? StartTableViewCell else { return UITableViewCell() }
    
        //도큐먼트에서 가져오기
        cell.mainImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectID).jpg")
        
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.dateLabel.text = tasks[indexPath.row].diaryDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // UIContextualAction이랑 UIView는 거의 안씀.
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            //realm 데이터 업데이트
            try! self.localRealm.write{
                //하나의 레코드에서 특정 컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                //하나의 테이블에 특정 컬럼 전체 값을 변경
//                self.tasks.setValue(true, forKey: "favorite")
                
                //하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["ObjectId": tasks[indexPath.row].objectID, "diaryTitle": "ㅅㄴㅁㅇㄹ"], update: .modified)

            }
        // 1. 스와이프한 셀 하나만 리로드로우 -> 상대적으로 효율성
        //2. 데이터가 변경됐으니 다시 realm에서 데이터 가져오기 -> didSet 일관적형태로 갱신
        self.fetchRealm()
        }
        
        //realm 데이터 기준으로 이미지 확ㅇ니
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star" // record에서 특정 컬럼 하나만 변경
        favorite.image = UIImage(systemName: image)
//        favorite.backgroundColor = .systemTeal

        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //도큐먼트에 저장한 이미지까지 잘 지워줘야함
        
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            try! self.localRealm.write {
                self.localRealm.delete(self.tasks[indexPath.row])
            }
            self.fetchRealm()
            
            self.removeImageFromDocument(fileName: "\(self.tasks[indexPath.row].objectID).jpg")
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
