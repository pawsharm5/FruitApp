//
//  APIManager.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

/// `API (Endevour & Middleware) Manager`
final class APIManager {
    /// Router to call custom get/post request via Endevour
    private let serverRouter: APIRouter<ServerEndpoint>
    /// Session Manager
    private let sessionManager: SessionManagerProtocol


    /// `initializer`
    /// - Parameters:
    ///   - sessionManager: Session Manager
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
        self.serverRouter = APIRouter<ServerEndpoint>()
    }
}

// ----------------------------------
// MARK: - APIManager Protocol Request -
//

/// `APIManager Protocol`
protocol APIManagerProtocol: AnyObject {
    /// `Fruits` API
    func getAllFruits(completion: @escaping (Result<FruitsListModel?, APIError>) -> Void)
}

extension APIManager: APIManagerProtocol {
    /// `Fruits` API
    func getAllFruits(completion: @escaping (Result<FruitsListModel?, APIError>) -> Void) {
        serverRouter.request(.getAllFruits, decode: { json -> FruitsListModel? in
            guard let results = json as? FruitsListModel? else { return  nil }
            return results
        }, completion: completion)
    }
}
