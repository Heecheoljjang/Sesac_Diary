//
//  BackupViewController.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import UIKit
import Zip
import SwiftUI

class BackupViewController: BaseViewController {
    
    var mainView = BackupView()
    
    var backupArray: [String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        
        mainView.backupTableView.delegate = self
        mainView.backupTableView.dataSource = self
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        
        //확인해보기위해
        //fetchDocumentZipFile()
        
        //테이블뷰에 백업 목록 파일 불러와야함.
        backupArray = fetchDocumentZipFile().map { "\($0.split(separator: ".")[0])" }

    }
    
    override func setUpNavigationController() {
//        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissView))
       // navigationItem.leftBarButtonItem = dismissButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        title = "데이터 백업 및 복구"
    }
    
    @objc func dismissView() {
        transition(self, transitionSytle: .pop)
    }
    
    @objc func backupButtonClicked() {
        
        var urlPath = [URL]() //백업할 파일들의 url배열
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 백업"
        let date = dateFormatter.string(from: Date())
        
        //도큐먼트 위치에 백업 파일이 있는지 확인
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치 오류")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm") //도큐먼트 폴더에서 한 번더 어펜딩해서 path 구함
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else { //파일 존재하는지
            showAlert(title: "백업할 파일 없음.")
            return
        }
        
        urlPath.append(URL(string: realmFile.path)!) //배열에 추가
        
        //백업 파일이 있따면 압축: URL배열
        do {
            
            let zipFilePath = try Zip.quickZipFiles(urlPath, fileName: "\(date)")
            backupArray.append("\(date)")
            print("zipFile: \(zipFilePath)")
            showActivityViewController(name: "\(date)")
        } catch {
            showAlert(title: "압축 실패")
        }
        mainView.backupTableView.reloadData()
    }
    
    @objc func restoreButtonClicked() {
        
        //파일앱에서 가져오기
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
        
    }
    
    func showActivityViewController(name: String) {
        //도큐먼트 위치에 백업 파일이 있는지 확인
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치 오류")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(name + ".zip") //도큐먼트 폴더에서 한 번더 어펜딩해서 path 구함
        
        //새싹파일의 url을 가지고 와야
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //한개만 선택하므로 first
        guard let selectedFileURL = urls.first else {
            showAlert(title: "선택한 파일에 오류있음.")
            return
        }
        
        //도큐먼트 위치 필요
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치 오류")
            return
        }
        
        //마지막 컴포넌트 가져오는것. a/b/c/d.zip이면 d.zip가져옴
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //경로에 파일이 존재하는지 -> 이미 복구할 파일을 갖고 있는 것이기때문에 압축 파일 풀어주기만 하면됨
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            //파일에 대한 경로
            //let fileURL = selectedFileURL //위의 sandboxFileURL과 같은 곳을 가리키지만 명시적으로 표시하기위해
            do {
                //프로그래스는 몇퍼센트 풀렸느지 알려주는 매개변수, destination은 어디 풀어줄지, 덮어씌우면 대치됨
                try Zip.unzipFile(selectedFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    //로딩바같은걸로 시각화가능
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert(title: "앱을 다시 실행해주세요!")
                    
                })
            } catch {
                showAlert(title: "압축 해제 실패")
            }
            
        } else {
            //경로에 파일이 없기때문에 파일앱에서 카피해주는 과정 필요
            
            do {
                //파일앱의 zip을 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
//                let fileURL = path.appendingPathComponent("SesacDiary_1.zip")
                
                try Zip.unzipFile(selectedFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert(title: "앱을 다시 실행해주세요!")
                })
            } catch {
                showAlert(title: "압축 해제 실패")
            }
            
        }
    }
}
