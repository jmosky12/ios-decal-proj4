//
//  NewPostViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var newPostTextView: UITextView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var picTitleLabel: UILabel!
    @IBOutlet weak var cancelPicButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        
        picTitleLabel.hidden = true
        cancelPicButton.hidden = true
        cancelPicButton.layer.cornerRadius = 15.0
        newPostTextView.layer.cornerRadius = 5.0
        uploadPhotoButton.layer.cornerRadius = 5.0
        postButton.layer.cornerRadius = 5.0
    
        
    }

    @IBAction func uploadPhotoPressed(sender: UIButton) {
    }

    @IBAction func postPressed(sender: UIButton) {
    }
    
    @IBAction func cancelPicPressed(sender: UIButton) {
    }

}
