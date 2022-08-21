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
    
    func getImageUrl(page: Int, query: String, completionHandler: @escaping ([ImageSearchModel]) -> ()) {
        
        let url = EndPoint.imageURL + "page=\(page)&query=\(query)&client_id=\(APIKey.unsplashKey)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let imageList: [ImageSearchModel] = json["results"].arrayValue.map { ImageSearchModel(full: $0["urls"]["full"].stringValue, raw: $0["urls"]["raw"].stringValue, thumb: $0["urls"]["thumb"].stringValue, regular: $0["urls"]["regular"].stringValue) }
                completionHandler(imageList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
