//
//  PhotoTableViewCell.swift
//  Flickr
//
//  Created by 580380 on 4/22/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    func setUpCell(model: PhotoModel) {
        self.photoTitle.text = model.title
        
        if let image =  model.image {
            photo.image = image
        } else {
            self.photo.downloadImage(model.mediumPhotoUrl, callback: { (image) in
                model.image = image
            })
        }
    }
}
