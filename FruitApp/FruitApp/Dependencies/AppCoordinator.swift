//
//  AppCoordinator.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

// MARK: AppCoordinator protocol
protocol AppCoordinatorProtocol: Coordinator {
    
}

// MARK: AppCoordinator will be launched at the very beginning
final class AppCoordinator: AppCoordinatorProtocol {
    private var window: UIWindow
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: AppNavigationControllerProtocol

    /// `initializer`
    /// - Parameters:
    ///   - window: app window
    ///   - dependencies: Dependency Container Object
    init(window: UIWindow, dependencies: DependencyContainerProtocol) {
        let navigationController: AppNavigationControllerProtocol = AppNavigationController()
        self.dependencies = dependencies
        window.rootViewController = navigationController as? AppNavigationController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
        self.window = window
    }

    /// start the flow
    func start() {
        print(Environment.serverURL)
        showFruitList()
    }
}

extension AppCoordinator {
    
    /// Initiate Home Coordinator
    func showFruitList() {
        let homeViewCoordinator = HomeViewCoordinator(dependencies: dependencies, navigationController: navigationController)
        homeViewCoordinator.start()
    }
}
