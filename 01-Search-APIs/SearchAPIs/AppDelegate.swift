//
//  AppDelegate.swift
//  SearchAPIs
//
//  Created by Chris Grant on 18/06/2015.
//  Copyright © 2015 Scott Logic Ltd. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        // Find the ID from the user info
        let friendID = userActivity.userInfo?["kCSSearchableItemActivityIdentifier"] as! String
        
        // Find the root table view controller and make it show the friend with this ID.
        let navigationController = (window?.rootViewController as! UINavigationController)
        navigationController.popToRootViewControllerAnimated(false)
        let friendTableViewController = navigationController.viewControllers.first as! FriendTableViewController
        friendTableViewController.showFriend(friendID)
        
        return true
    }
}
