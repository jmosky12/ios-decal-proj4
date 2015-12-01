//
//  UserProfileViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    let textColor = UIColor.whiteColor()
    let textFont = UIFont(name: "Avenir", size: 40.0)
    
    init() {
        super.init(nibName: "UserProfileViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
