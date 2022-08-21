//
//  ImageAPIManager.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/21.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageAPIManager {
    
    private init() {}
    
    static let shared = ImageAPIManager()
    
    func getImageUrl(page: Int, query: String, completionHandler: @escaping (String) -> ()) {
        
        let url = EndPoint.imageURL + "page=\(page)&query=\(query)&client_id=\(APIKey.unsplashKey)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
