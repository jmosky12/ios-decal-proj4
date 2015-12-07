//
//  UserProfileViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

protocol UserProfileViewControllerDelegate {
    func getBioText() -> String
    func setBioText(text: String)
    func changePicture(image: UIImage)
}

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UserProfileViewControllerDelegate, PostTable  {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioTextView: UITextView!
    @IBOutlet weak var userTableView: UITableView!
    
    let textColor = UIColor.whiteColor()
    let textFont = UIFont(name: "Avenir", size: 30.0)
    var editingBio = false
    var posts:[Post] = [Post]()
    init() {
        super.init(nibName: "UserProfileViewController", bundle: nil)
        userTableView = UITableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func refresh() {
        getPosts()
    }
    
    
    func getPosts() {
        //1
        let query = Post.querySingleUser(PFUser.currentUser()!)!
        query.findObjectsInBackgroundWithBlock { objects, error in
            if error == nil {
                //2
                if let objects = objects as? [Post] {
                    //   self.loadPosts(objects)
                    self.posts = objects.filter { element in
                        let since:Int = Int((element.createdAt?.timeIntervalSinceNow)!)
                        return element.duration + since > 0
                    }
                    
                    self.userTableView.reloadData()
                }
            } else if let error = error {
                //3
                print(error)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        self.userTableView.backgroundColor = UIColor(red: 160.0/255.0, green: 155.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        let nib: UINib = UINib(nibName: "PostTableViewCell", bundle: nil)
        userTableView.registerNib(nib, forCellReuseIdentifier: "postCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.estimatedRowHeight = 100
        userTableView.rowHeight = UITableViewAutomaticDimension
        userTableView.layer.cornerRadius = 5.0
        userTableView.separatorColor = UIColor.whiteColor()
        userTableView.separatorInset = UIEdgeInsetsZero
        userTableView.preservesSuperviewLayoutMargins = false
        userTableView.layoutMargins = UIEdgeInsetsZero
        
        userBioTextView.layer.cornerRadius = 5.0
        
        let img = UIImage(named: "pic2")
        userAvatar.image = img
        userAvatar.clipsToBounds = true
        userAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        userAvatar.layer.cornerRadius = 5.0
        
        let editProfileButton = UIBarButtonItem(title: "Edit Profile", style: UIBarButtonItemStyle.Plain, target: self, action: "editProfile")
        self.navigationItem.leftBarButtonItem = editProfileButton

        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
        let currentUser = PFUser.currentUser()!
        if let text = currentUser["bio"] {
            userBioTextView.text = text as! String
        }
        if let avatar = currentUser["avatar"] {
            avatar.getDataInBackgroundWithBlock { data, error in
                if let image = UIImage(data: data!) {
                    self.userAvatar.image = image
                }
            }
        }
        
        let nib1: UINib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.userTableView.registerNib(nib1, forCellReuseIdentifier: "postCell")
        let nib2: UINib = UINib(nibName: "PhotoPostTableViewCell", bundle: nil)
        self.userTableView.registerNib(nib2, forCellReuseIdentifier: "photoCell")
        let nib3: UINib = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        self.userTableView.registerNib(nib3, forCellReuseIdentifier: "blank")
        userNameLabel.text = currentUser["username"] as! String
        getPosts()
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
        if posts.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
            cell.textLabel!.text = "Nothing to show. Post something!"
            
            return cell
        }
        if let x = posts[indexPath.row].image
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoPostTableViewCell
            cell.post = self.posts[indexPath.row]
            x.getDataInBackgroundWithBlock { data, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        cell.uploadedImage!.image = image
                        
                    }
                }
            }
            if let y = posts[indexPath.row].user.objectForKey("avatar") {
                y.getDataInBackgroundWithBlock { data, error in
                    if let image = UIImage(data: data!) {
                        cell.avatarImage!.image = image
                    }
                }
            }
            cell.postText.text = self.posts[indexPath.row].comment
            let since:Int = Int((self.posts[indexPath.row].createdAt?.timeIntervalSinceNow)!)
            cell.postInfo.text = String(self.posts[indexPath.row].duration + since) + " s"
            let duration: Float = Float(self.posts[indexPath.row].duration + since)
            cell.userName.setTitle(self.posts[indexPath.row].user.username, forState: .Normal)
            let pressedInfo = UITapGestureRecognizer(target: self, action: "didPressInfo:")
            cell.postInfo.addGestureRecognizer(pressedInfo)
            cell.postInfo.tag = indexPath.row
            if duration >= 60 {
                cell.progressBar.setProgress(1.0, animated: true)
            } else {
                cell.progressBar.setProgress(duration/60, animated: true)
            }
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        if let y = posts[indexPath.row].user.objectForKey("avatar") {
            y.getDataInBackgroundWithBlock { data, error in
                if let image = UIImage(data: data!) {
                    cell.avatarImage!.image = image
                }
            }
        }
        cell.post = self.posts[indexPath.row]
        cell.postText.text = posts[indexPath.row].comment
        let since:Int = Int((self.posts[indexPath.row].createdAt?.timeIntervalSinceNow)!)
        cell.postInfo.text = String(self.posts[indexPath.row].duration + since) + " s"
        let duration: Float = Float(self.posts[indexPath.row].duration + since)
        cell.userName.setTitle(posts[indexPath.row].user.username, forState: .Normal)
        let pressedInfo = UITapGestureRecognizer(target: self, action: "didPressInfo:")
        cell.postInfo.addGestureRecognizer(pressedInfo)
        cell.postInfo.tag = indexPath.row
        if self.posts[indexPath.row].duration + since >= 60 {
            cell.progressBar.setProgress(1.0, animated: true)
        } else {
            cell.progressBar.setProgress(duration/60, animated: true)
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts.count > 0 {
            return posts.count
        }
        return 1
    }
    
    func editProfile() {
        let vc = EditProfileViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getBioText() -> String {
        return userBioTextView.text
    }
    
    func setBioText(text: String) {
        userBioTextView.text = text
    }
    
    func changePicture(image: UIImage) {
        userAvatar.image = image
    }

}
