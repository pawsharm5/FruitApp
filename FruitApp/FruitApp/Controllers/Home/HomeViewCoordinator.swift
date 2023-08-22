//
//  HomeViewCoordinator.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

protocol HomeViewCoordinatorProtocol: Coordinator {
    
}

class HomeViewCoordinator: HomeViewCoordinatorProtocol {
    
    /// private `variables`
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: AppNavigationControllerProtocol
    private let homeBuilder: HomeViewBuilderProtocol
    
    /// `initializer`
    /// - Parameters:
    ///   - dependencies: Dependency Container Object

    init(dependencies: DependencyContainerProtocol,
         navigationController: AppNavigationControllerProtocol) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.homeBuilder = HomeViewBuilder(apiManager: dependencies.apiManager)
    }

    /// start the flow
    func start() {
        let viewController = homeBuilder.build(with: self)
        navigationController.push(viewController: viewController, animated: true)
    }
}

extension HomeViewCoordinator: HomeViewNavigatorProtocol {
    func showFruitDetails(for fruit: FruitsListModelElement) {
        let fruitDetailsCoordinator = FruitDetailsCoordinator(dependencies: dependencies, navigationController: navigationController, fruitData: fruit)
        fruitDetailsCoordinator.start()
    }
}
