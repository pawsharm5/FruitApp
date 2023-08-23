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
    var appCoordinator: AppCoordinatorProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let dependacies = DependenciesAllocator.allocate()
        let navigationController: AppNavigationControllerProtocol = AppNavigationController()
        window!.makeKeyAndVisible()
        appCoordinator = AppCoordinator(window: window!, dependencies: dependacies, navigationController: navigationController)
        appCoordinator?.start()
        return true
    }
}

