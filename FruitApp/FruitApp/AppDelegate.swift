//
//  AppDelegate.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(storyboard: .Main)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

