//
//  PhotoModel.swift
//  Flickr
//
//  Created by 580380 on 4/19/16.
//  Copyright © 2016 580380. All rights reserved.
//
import UIKit

class PhotoModel {
    
    //instance properties
    var id: String
    var farm: Int
    var server: String
    var secret: String
    var title: String
    var image: UIImage?
    
    //initializer
    init(id: String, farm: Int, server: String, secret: String, title: String) {
        self.id = id
        self.farm = farm
        self.server = server
        self.secret = secret
        self.title = title
    }
    
    //computed properties
    var mediumPhotoUrl : String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
    
    var largePhotoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_h.jpg"
    }
    
}
