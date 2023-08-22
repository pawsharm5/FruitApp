//
//  HomeViewBuilder.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

protocol HomeViewBuilderProtocol {
    /// Build Profile stack
    /// - Returns: UIViewController
    func build(with navigator: HomeViewNavigatorProtocol) -> UIViewController
}

struct HomeViewBuilder: HomeViewBuilderProtocol {
    
    /// API Manager
    let apiManager: APIManagerProtocol
    
    func build(with navigator: HomeViewNavigatorProtocol) -> UIViewController {
        let destination = StoryboardScene.Main.homeView.instantiate { coder in
            let viewModel = HomeViewModel(apiManager: apiManager, navigator: navigator)
            return HomeViewController(coder: coder, viewModel: viewModel)
        }
        return destination
    }
}
