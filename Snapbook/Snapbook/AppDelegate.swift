//
//  AppDelegate.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController!
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        logInController.logInView?.usernameField?.text = ""
        logInController.logInView?.passwordField?.text = ""

        logInController.presentViewController(tabBarController!, animated: true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
//        signUpController.dismissViewControllerAnimated(true, completion: nil)
        signUpController.signUpView?.usernameField?.text = ""
        signUpController.signUpView?.passwordField?.text = ""
        signUpController.signUpView?.emailField?.text = ""

        signUpController.presentViewController(tabBarController!, animated: true, completion: nil)
//        signUpController.dismissViewControllerAnimated(false, completion: nil)

    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        
        let postFeed = PostFeedTableViewController()
        let postFeedNC = UINavigationController(rootViewController: postFeed)
        postFeedNC.tabBarItem.title = "Feed"
        postFeedNC.tabBarItem.tag = 1
        postFeedNC.navigationBar.barTintColor = UIColor.blackColor()
        postFeedNC.navigationBar.tintColor = UIColor.whiteColor()
        postFeedNC.navigationBar.topItem?.title = "News Feed"
        postFeedNC.navigationBar.translucent = false
        
        let userProfile = UserProfileViewController()
        let userProfileNC = UINavigationController(rootViewController: userProfile)
        userProfileNC.tabBarItem.title = "Profile"
        userProfileNC.tabBarItem.tag = 2
        userProfileNC.navigationBar.barTintColor = UIColor.blackColor()
        userProfileNC.navigationBar.tintColor = UIColor.whiteColor()
        userProfileNC.navigationBar.topItem?.title = "Profile"
        userProfileNC.navigationBar.translucent = false
        
        let controllers = [postFeedNC, userProfileNC]
        
        tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        self.window?.addSubview(tabBarController.view)

        let login = PFLogInViewController()
        login.title = "SnapBook"
        login.logInView?.logo?.hidden = true
        login.delegate = self
        login.signUpController?.delegate = self
        login.logInView?.dismissButton?.hidden = true
        window?.rootViewController = login

        
        self.window?.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = UIColor(red: 60.0/255.0, green: 10.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        UITabBar.appearance().translucent = false
        
        Parse.setApplicationId("oxaxKBeRfV0SPggTnmaNn5YuTWJIhv56jv3pZIGK", clientKey: "33wGUNkGqctKoQ5WkRXBcSgKI4RuBzQI40KoJiH3")
        if let user = PFUser.currentUser() {
            if user.authenticated {
                login.presentViewController(tabBarController, animated: false, completion: nil)
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jmoskowitz.Snapbook" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Snapbook", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

