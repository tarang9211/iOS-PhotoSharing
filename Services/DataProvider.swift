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
import OAuthSwift

typealias PhotoModel_Alias = (NSError?, [PhotoModel]?) -> Void
typealias CommentModel_Alias = (NSError?, [CommentModel]?) -> Void

class DataProvider {
    
    private init() {}
    let userDefaults = NSUserDefaults.standardUserDefaults()
    static let sharedInstance = DataProvider()
    var token = ""

    
    //This methods returns a list of photos on Flickr Explore
    func fetchExplorePhotos(onCompletion: PhotoModel_Alias) {
        
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?", parameters:
                            ["method"        : "flickr.interestingness.getList",
                            "api_key"        : Constants.apiKey,
                            "per_page"       : "100",
                            "format"         : "json",
                            "nojsoncallback" : "1"]
            )
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
    
    /*
     This method returns comments for a particular photo
     This method should only get called after a user has been authenticated since auth_token gets send as query string params
    */
    func fetchComments(id: String, onCompletion: CommentModel_Alias) {
        
        //check if user is authenticated aka auth_token exists
        guard let authToken = userDefaults.objectForKey(Constants.token) as? String else {
            return
        }
        
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?", parameters:
                            ["method"           : "flickr.photos.comments.getList",
                             "api_key"          : Constants.apiKey,
                             "photo_id"         : id,
                             "auth_token"       : authToken,
                             "format"           : "json",
                             "nojsoncallback"   : "1"]
        )
        .responseJSON { response in
            
            switch response.result {
                
            case .Failure:
                if let err = response.result.error {
                    onCompletion(err, nil)
                }
                
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                }
            }
        }
    }

    let auth = OAuth1Swift(
        consumerKey: Constants.apiKey,
        consumerSecret: Constants.clientSecret,
        requestTokenUrl: Constants.requestTokenUrl,
        authorizeUrl: Constants.authorizeUrl,
        accessTokenUrl: Constants.accessTokenUrl
    )
    
    func login() {
        
        auth.authorizeWithCallbackURL(NSURL(string: "com.th.Flickr://oauth-callback/flickr")!, success: { credential, response, parameters in
            
                if let tempToken = parameters["oauth_token"] {
                    self.token = tempToken
                }
                self.userDefaults.setObject(self.token, forKey: Constants.token)
                self.userDefaults.setBool(true, forKey: Constants.isLoggedIn)
            
            }, failure: { error in
                print(error.localizedDescription)
                self.userDefaults.setBool(false, forKey: Constants.isLoggedIn)
        })
    }
}












