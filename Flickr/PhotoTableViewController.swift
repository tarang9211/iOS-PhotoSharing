//
//  PhotoTableViewController.swift
//  Flickr
//
//  Created by 580380 on 4/20/16.
//  Copyright © 2016 580380. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    let dataProvider = DataProvider.sharedInstance
    var photos = [PhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - TableView methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier, forIndexPath: indexPath) as! PhotoTableViewCell
        cell.setUpCell(photos[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(Constants.segueIdentifier, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.segueIdentifier {
            let detailViewController = segue.destinationViewController as! PhotoDetailViewController
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                detailViewController.model = photos[selectedIndexPath.row]
            }
        }
    }
    
    //MARK: - Data Call methods
    private func getPhotos() {
        dataProvider.fetchExplorePhotos { (error, data) in
            if error != nil { /* process error */ }
            
            if data != nil {
                self.photos = data!
                self.tableView.reloadData()
            }
        }
    }
}
