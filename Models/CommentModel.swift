//
//  CommentModel.swift
//  Flickr
//
//  Created by 580380 on 4/22/16.
//  Copyright © 2016 580380. All rights reserved.
//

import Foundation

class CommentModel {
    var id: String
    var authorId: String
    var authorName: String
    var createDate: NSDate
    var content: String
    
    init(id: String, authorId: String, authorName: String, createDate: NSDate, content: String) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.createDate = createDate
        self.content = content
    }
    
}
