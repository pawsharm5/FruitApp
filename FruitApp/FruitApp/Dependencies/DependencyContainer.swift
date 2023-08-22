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
    
    /// Session Manager
    var sessionManager: SessionManagerProtocol { get }
}

// MARK: Confirming to Resource Protocol
final class DependencyContainer: DependencyContainerProtocol {
    
    var apiManager: APIManagerProtocol
    var sessionManager: SessionManagerProtocol

    init(apiManager: APIManagerProtocol, sessionManager: SessionManagerProtocol) {
        self.apiManager = apiManager
        self.sessionManager = sessionManager
    }
}

// MARK: Allocator for DependencyContainer
final class DependenciesAllocator {
    // Allocates all dependencies
    static func allocate() -> DependencyContainerProtocol {
        let sessionManager = SessionManager()
        return DependencyContainer(apiManager: APIManager(sessionManager: sessionManager),
                                   sessionManager: sessionManager)
    }
}
