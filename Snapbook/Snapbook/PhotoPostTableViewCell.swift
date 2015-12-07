//
//  PhotoPostTableViewCell.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class PhotoPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var postInfo: UILabel!
    var post:Post!
    var delegate:PostTable!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        self.selectionStyle = .None
        
        let img = UIImage(named: "pic2")
        avatarImage.image = img
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = UIViewContentMode.ScaleAspectFit
        avatarImage.layer.cornerRadius = 5.0
        
        
        uploadedImage.clipsToBounds = true
        uploadedImage.contentMode = UIViewContentMode.ScaleAspectFit

        postInfo.layer.cornerRadius = 5.0
        postInfo.clipsToBounds = true
        
        progressBar.tintColor = UIColor(red: 60.0/255.0, green: 10.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        
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
            delegate.refresh()
    }
    
}
