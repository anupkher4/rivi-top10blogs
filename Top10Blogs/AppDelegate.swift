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

        guard let service = loadAndDecodeJson() else {
            return true
        }

        let viewModel = DashboardViewModelImpl(service: service)
        let rootViewController = DashboardViewController(viewModel: viewModel)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

    private func loadAndDecodeJson() -> FoodBlogService? {
        guard let path = Bundle.main.path(forResource: "RiviServerData", ofType: "json") else {
            print("File not found")
            return nil
        }
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("String parsing failed")
            return nil
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Could not create data from json string")
            return nil
        }
        let decoder = JSONDecoder()
        guard let service = try? decoder.decode(FoodBlogService.self, from: jsonData) else {
            print("Could not decode json data")
            return nil
        }
        return service
    }

}

