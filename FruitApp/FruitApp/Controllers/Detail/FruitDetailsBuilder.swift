//
//  FruitDetailBuilder.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

protocol FruitDetailsBuilderProtocol {

    func build(with navigator: FruitDetailsNavigatorProtocol, fruit: FruitsListModelElement) -> UIViewController
}

struct FruitDetailsBuilder: FruitDetailsBuilderProtocol {
    /// API Manager
    let apiManager: APIManagerProtocol
    
    func build(with navigator: FruitDetailsNavigatorProtocol, fruit: FruitsListModelElement) -> UIViewController {
        let destination = StoryboardScene.Main.fruitDetails.instantiate { coder in
            let viewModel = FruitDetailViewModel(apiManager: apiManager, navigator: navigator, fruitData: fruit)
            return FruitDetailsViewController(coder: coder, viewModel: viewModel)
        }
        return destination
    }
}
