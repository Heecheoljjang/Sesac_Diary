//
//  StartViewController+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/22.
//

import UIKit
import RealmSwift // 1. 임포트
import FSCalendar


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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        vc.diary = Diary(image: "\(tasks[indexPath.row].objectID).jpg", title: tasks[indexPath.row].diaryTitle, date: tasks[indexPath.row].diaryDate, body: tasks[indexPath.row].diaryContent ?? "")
        
        transition(vc, transitionSytle: .push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // UIContextualAction이랑 UIView는 거의 안씀.
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            //realm 데이터 업데이트
            self.repository.updateFavorite(item: self.tasks[indexPath.row])

        }
        let image = self.tasks[indexPath.row].favorite ? "star.fill" : "star" // record에서 특정 컬럼 하나만 변경
        favorite.image = UIImage(systemName: image)
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //도큐먼트에 저장한 이미지까지 잘 지워줘야함
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            self.repository.deleteItem(item: self.tasks[indexPath.row])
            self.mainView.tableView.reloadData()
            self.mainView.calendar.reloadData()
        }
        delete.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension StartViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    //무조건 점 하나
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateText = dateToString(date)
        if repository.fetchDate(date: dateText).count != 0 {
            return 1
        } else {
            return 0
        }
    }

//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return nil
//    }

    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return nil
    }

//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }

    //date형식이 불편하게 되어있음. 시 분초까지 다 맞아야 문제없게됨 => dateFormatter를 통해서 변경 필요
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return nil
    }

    //렘 데이터 날짜에 따라 몇개의 글이 있는지
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateText = dateToString(date)
        tasks = repository.fetchDate(date: dateText)
    }
}
