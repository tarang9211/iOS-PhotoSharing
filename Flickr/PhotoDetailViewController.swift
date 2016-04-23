//
//  PhotoDetailViewController.swift
//  Flickr
//
//  Created by 580380 on 4/22/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var model: PhotoModel?
    @IBOutlet weak var photo: UIImageView!
    let dataProvider = DataProvider.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureView() {
        guard let photoModel = model else {
            return
        }
        self.title = photoModel.title
        photo.downloadImage(photoModel.largePhotoUrl, duration: 0.20)
    }
    
    private func getComments() {
        
    }

}
