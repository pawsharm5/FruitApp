//
//  DependencyContainer.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

protocol DependencyContainerProtocol {
    
    // This protocol will be confirming to the services
    // needed like API manager
    
    /// API Manager
    var apiManager: APIManagerProtocol { get }
    
}

// MARK: Confirming to Resource Protocol
/// Single Responsibility
final class DependencyContainer: DependencyContainerProtocol {
    
    private(set) var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

// MARK: Allocator for DependencyContainer
final class DependenciesAllocator {
    // Allocates all dependencies
    static func allocate() -> DependencyContainerProtocol {
        return DependencyContainer(apiManager: APIManager())
    }
}
