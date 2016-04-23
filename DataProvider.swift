//
//  DataProvider.swift
//  Flickr
//
//  Created by 580380 on 4/19/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias PhotoModel_Alias = (NSError?, [PhotoModel]?) -> Void
typealias CommentModel_Alias = (NSError?, [CommentModel]?) -> Void

class DataProvider {
    
    static let sharedInstance = DataProvider()
    private init() {}
    
    //This methods returns a list of photos on Flickr Explore
    func fetchExplorePhotos(onCompletion: PhotoModel_Alias) {
        
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?", parameters:
                            ["method" : "flickr.interestingness.getList",
                            "api_key" : Constants.apiKey,
                            "per_page": "100",
                            "format"  : "json",
                            "nojsoncallback" : "1"])
        .responseJSON { response in
            
            switch response.result {
                
            case .Failure:
                if let error = response.result.error {
                    onCompletion(error, nil)
                }
                
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let photos = json["photos"]["photo"].arrayValue
                    
                    let photoModel : [PhotoModel] =  photos.map {
                        item in
                        let id = item["id"].stringValue
                        let farm = item["farm"].intValue
                        let server = item["server"].stringValue
                        let secret = item["secret"].stringValue
                        let title = item["title"].stringValue
                        let model = PhotoModel(id: id, farm: farm, server: server, secret: secret, title: title)
                        return model
                    }
                    onCompletion(nil, photoModel)
                }
            }
        }
    }
    
    //This method returns comments for a particular photo
    func fetchComments(id: String, onCompletion: CommentModel_Alias) {
        
    }
}












