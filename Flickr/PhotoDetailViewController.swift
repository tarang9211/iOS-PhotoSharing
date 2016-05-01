//
//  PhotoDetailViewController.swift
//  Flickr
//
//  Created by 580380 on 4/22/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit
import OAuthSwift

class PhotoDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var commentsTable: UITableView!
    
    var model: PhotoModel?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let dataProvider = DataProvider.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.navigationController?.delegate = self
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
    
    @IBAction func signInAction(sender: AnyObject) {
        dataProvider.login()
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        print("called")
    }
}
