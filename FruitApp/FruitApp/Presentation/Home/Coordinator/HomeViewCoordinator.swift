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
    
    /// `initializer`
    /// - Parameters:
    ///   - dependencies: Dependency Container Object

    init(dependencies: DependencyContainerProtocol,
         navigationController: AppNavigationControllerProtocol) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    /// start the flow
    func start() {
        let destination = StoryboardScene.Main.homeView.instantiate { coder in
            let viewModel = HomeViewModel(navigator: self, useCase: HomeUseCase(repo: Repository(service: Services(apiManager: self.dependencies.apiManager), mapper: FruitsListMapper())))
            return HomeViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.push(viewController: destination, animated: true)
    }
}

protocol HomeViewNavigatorProtocol {
    func showFruitDetails(for fruit: FruitsListModelElement)
}

extension HomeViewCoordinator: HomeViewNavigatorProtocol {
    func showFruitDetails(for fruit: FruitsListModelElement) {
        let fruitDetailsCoordinator = FruitDetailsCoordinator(dependencies: dependencies, navigationController: navigationController, fruitId: "\(fruit.id ?? 0)")
        fruitDetailsCoordinator.start()
    }
}
