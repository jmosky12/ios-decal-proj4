//
//  UserProfileViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioTextView: UITextView!
    @IBOutlet weak var userTableView: UITableView!
    
    let textColor = UIColor.whiteColor()
    let textFont = UIFont(name: "Avenir", size: 40.0)
    var editingBio = false
    
    init() {
        super.init(nibName: "UserProfileViewController", bundle: nil)
        userTableView = UITableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        
        let nib: UINib = UINib(nibName: "PostTableViewCell", bundle: nil)
        userTableView.registerNib(nib, forCellReuseIdentifier: "postCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.estimatedRowHeight = 100
        userTableView.rowHeight = UITableViewAutomaticDimension
        userTableView.layer.cornerRadius = 5.0
        userTableView.separatorColor = UIColor.blackColor()
        
        userBioTextView.layer.cornerRadius = 5.0
        let bioTapped = UITapGestureRecognizer(target: self, action: "bioTextViewTapped")
        userBioTextView.addGestureRecognizer(bioTapped)
        
        let img = UIImage(named: "pic2")
        userAvatar.image = img
        userAvatar.clipsToBounds = true
        userAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        userAvatar.layer.cornerRadius = 5.0
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newPost")
        self.navigationItem.rightBarButtonItem = addButton

        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    func bioTextViewTapped() {
        //add check that user matches profile
        if editingBio == false {
            userBioTextView.editable = true
            editingBio = true
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            userBioTextView.editable = false
            editingBio = false
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func newPost() {
        let vc = NewPostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
