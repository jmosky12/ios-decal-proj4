//
//  Post.swift
//  Snapbook
//
//  Created by Alex Zhang on 12/5/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import Foundation
class Post: PFObject, PFSubclassing {
    @NSManaged var image: PFFile?
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    

    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Post.parseClassName()) //1
        query.includeKey("user") //2
        query.orderByDescending("createdAt") //3
        return query
    }
    
    init(image: PFFile?, user: PFUser, comment: String?) {
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
    }
    
    class func parseClassName() -> String {
        return "SnapPost"
    }
    
    override init() {
        super.init()
    }
    
}