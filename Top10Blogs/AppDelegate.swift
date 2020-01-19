//
//  AppDelegate.swift
//  Top10Blogs
//
//  Created by Anup Kher on 17/01/20.
//  Copyright © 2020 amprojects. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = .systemPink

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

}

