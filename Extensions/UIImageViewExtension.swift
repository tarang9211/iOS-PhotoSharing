//
//  UIImageViewExtension.swift
//  Flickr
//
//  Created by 580380 on 4/22/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit
import Alamofire

typealias Image_Alias = UIImage -> Void

extension UIImageView {
    
    func downloadImage(url: String, duration: Double = 0.25, callback: Image_Alias = {_ in}) {
        
        //set a temporary image
        self.image = UIImage(named: "placeholder.jpg")
        
        //request to get the correct image
        Alamofire.request(.GET, url).responseData { (response) in
            
            switch response.result {
            case .Failure:
                if let error = response.result.error {
                    print("error: \(error)")
                }
                
            case .Success:
                if let data = response.result.value {
                    let img = UIImage(data: data)
                    UIView.transitionWithView(self, duration: duration, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                            self.image = img
                        }, completion: nil)
                }
            }
        }
    }
}
