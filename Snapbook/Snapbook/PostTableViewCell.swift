//
//  PostTableViewCell.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var postInfo: UILabel!
    var post:Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        self.selectionStyle = .None
        
        let img = UIImage(named: "blank-user")
        avatarImage.image = img
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = UIViewContentMode.ScaleAspectFit
        avatarImage.layer.cornerRadius = 5.0
        
        postInfo.layer.cornerRadius = 5.0
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func boostButtonPressed(sender: UIButton) {
        //var numBoosts (pulled from database) = #
            //postInfo.text = "\(numBoosts + 1) Boosts, 8h Remaining"
            //increase numBoosts in database by 1
            post.duration += 60
            post.score += 1

            post.saveInBackground()
            likeButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
            likeButton.enabled = false

    }
    
}
