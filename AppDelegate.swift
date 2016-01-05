//
//  AppDelegate.swift
//  PersonalCenter
//
//  Created by mjt on 15/11/29.
//  Copyright © 2015年 mjt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UINavigationBar.setupStyle()
        
        return true
    }

}

