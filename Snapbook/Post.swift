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
    @NSManaged var duration: Int
    @NSManaged var score: Int
    var boosted:Bool = false
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    override class func query() -> PFQuery? {
        return query(false)
    }
    class func querySingleUser(user: PFUser) -> PFQuery? {
        let query = PFQuery(className: Post.parseClassName()) //1
        query.whereKey("user", equalTo: user)
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    class func query(sort: Bool) -> PFQuery? {
        let query = PFQuery(className: Post.parseClassName()) //1
        query.includeKey("user") //2
        if sort {
            query.orderByDescending("score")
        } else {
            query.orderByDescending("createdAt") //3
        }
        return query
    }
    
    init(image: PFFile?, user: PFUser, comment: String?, duration: Int, score: Int) {
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
        self.duration = duration
        self.score = score
    }
    
    convenience init(image: PFFile?, user: PFUser, comment: String) {
        self.init(image: image, user: user, comment: comment, duration: 60, score: 0)
    }
    class func parseClassName() -> String {
        return "SnapPost"
    }
    
    override init() {
        super.init()
    }
    
}