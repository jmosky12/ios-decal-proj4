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
    @IBOutlet weak var postInfo: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var uploadedImage: UIImageView!
    
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
        
        let img2 = UIImage(named: "ny")
        uploadedImage.image = img2
        uploadedImage.clipsToBounds = true
        uploadedImage.contentMode = UIViewContentMode.ScaleAspectFit
        //doesnt scale well
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
