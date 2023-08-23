//
//  FruitDetailsCoordinator.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

protocol FruitDetailsCoordinatorProtocol: Coordinator {
    
}

class FruitDetailsCoordinator: FruitDetailsCoordinatorProtocol {
    
    /// private `variables`
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: AppNavigationControllerProtocol
    private let fruitId: String

    init(dependencies: DependencyContainerProtocol,
         navigationController: AppNavigationControllerProtocol, fruitId: String) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.fruitId = fruitId
    }

    /// start the flow
    func start() {
        let destination = StoryboardScene.Main.fruitDetails.instantiate { coder in
            let viewModel = FruitDetailViewModel(navigator: self, useCase: DetailUseCase(repo: Repository(service: Services(apiManager: self.dependencies.apiManager), mapper: FruitsListMapper())), fruitId: self.fruitId)
            return FruitDetailsViewController(coder: coder, viewModel: viewModel)
        }
        navigationController.push(viewController: destination, animated: true)
    }
}

extension FruitDetailsCoordinator: FruitDetailsNavigatorProtocol {

}

protocol FruitDetailsNavigatorProtocol {
    
}
