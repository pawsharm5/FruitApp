//
//  CoordinatorTest.swift
//  FruitAppTests
//
//  Created by Pawan Sharma on 22/08/23.
//

import XCTest
@testable import FruitApp

class CoordinatorTests: XCTestCase {
    func testWhenAppStart() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let dependacies = DependenciesAllocator.allocate()
        let navigationController: AppNavigationControllerProtocol = AppNavigationController()
        window.makeKeyAndVisible()
        let appCoordinator = AppCoordinator(window: window, dependencies: dependacies, navigationController: navigationController)
        appCoordinator.start()
    }
    
    
}
