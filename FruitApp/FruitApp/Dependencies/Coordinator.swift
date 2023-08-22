//
//  Coordinator.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

// MARK: - Coordinator protocol
protocol Coordinator: AnyObject {
    /// Commanly required dependacies
    var dependencies: DependencyContainerProtocol { get }
    
    /// Navigation protocol
    var navigationController: AppNavigationControllerProtocol { get }
    
    /// workflow
    func start()
}
