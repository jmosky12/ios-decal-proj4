//
//  PostFeedTableViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

protocol PostTable {
    func refresh()
}
class PostFeedTableViewController: UITableViewController, PostTable {
    
    let textColor = UIColor.whiteColor()
    let textFont = UIFont(name: "Avenir", size: 30.0)
    var posts = [Post]()
    var refreshCtrl: UIRefreshControl!
    var sortString: String!
    
    init(sort: String) {
        sortString = sort
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh() {
        getPosts()
    }
    
    func getPosts() {
        //1
        let query = Post.query()!
        query.findObjectsInBackgroundWithBlock { objects, error in
            if error == nil {
                //2
                if let objects = objects as? [Post] {
                 //   self.loadPosts(objects)
                    self.posts = objects.filter { element in
                        let since:Int = Int((element.createdAt?.timeIntervalSinceNow)!)
                        return element.duration + since > 0
                    }
                    self.tableView.reloadData()
                    self.refreshCtrl.endRefreshing()
                }
            } else if let error = error {
                //3
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newPost")
        self.navigationItem.rightBarButtonItem = addButton
        let logOutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.Plain, target: self, action: "logOutPressed")
        self.navigationItem.leftBarButtonItem = logOutButton
        self.view.backgroundColor = UIColor(red: 160.0/255.0, green: 155.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.whiteColor()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.layoutMargins = UIEdgeInsetsZero
        
        edgesForExtendedLayout = .None
        let nib1: UINib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.tableView.registerNib(nib1, forCellReuseIdentifier: "postCell")
        let nib2: UINib = UINib(nibName: "PhotoPostTableViewCell", bundle: nil)
        self.tableView.registerNib(nib2, forCellReuseIdentifier: "photoCell")
        let nib3: UINib = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        self.tableView.registerNib(nib3, forCellReuseIdentifier: "blank")
        getPosts()
        
        refreshCtrl = UIRefreshControl()
        tableView.insertSubview(refreshCtrl, atIndex: 0)
        refreshCtrl.addTarget(self, action: "getPosts", forControlEvents: .ValueChanged)
        
    }
    
    func logOutPressed() {
        PFUser.logOut()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didPressInfo(sender: UILabel) {
        //expand this cell and show its comments
    }
    
   

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts.count > 0 {
            return posts.count
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // if user.photoproperty == nil {
       
        /* } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoPostTableViewCell
        }*/
        
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
    
    func newPost() {
        let vc = NewPostViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)

        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
