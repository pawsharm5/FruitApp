//
//  FruitDetailsCoordinator.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

protocol FruitDetailsCoordinatorProtocol: Coordinator {
    
}

class FruitDetailsCoordinator: HomeViewCoordinatorProtocol {
    
    /// private `variables`
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: AppNavigationControllerProtocol
    private let detailBuilder: FruitDetailsBuilderProtocol
    private let fruitData: FruitsListModelElement

    init(dependencies: DependencyContainerProtocol,
         navigationController: AppNavigationControllerProtocol, fruitData: FruitsListModelElement) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.detailBuilder = FruitDetailsBuilder(apiManager: dependencies.apiManager)
        self.fruitData = fruitData
    }

    /// start the flow
    func start() {
        let viewController = detailBuilder.build(with: self, fruit: fruitData)
        navigationController.push(viewController: viewController, animated: true)
    }
}

extension FruitDetailsCoordinator: FruitDetailsNavigatorProtocol {

}
