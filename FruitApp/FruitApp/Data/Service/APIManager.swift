//
//  APIManager.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

/// `API (Endevour & Middleware) Manager`
///  Solid Open/Close principle
final class APIManager {
    /// Router to call custom get/post request via Endevour
    private let serverRouter: APIRouter<ServerEndpoint>
    /// Session Manager

    /// `initializer`
    /// - Parameters:
    ///   - sessionManager: Session Manager
    init() {
        self.serverRouter = APIRouter<ServerEndpoint>()
    }
}

// ----------------------------------
// MARK: - APIManager Protocol Request -
//

/// `APIManager Protocol`
protocol APIManagerProtocol: AnyObject {
    /// `Fruits` API
    //func getAllFruits(completion: @escaping (Result<FruitsListModel?, APIError>) -> Void)
    func fetchData<T: Decodable>(_ route: ServerEndpoint,
                               decode: @escaping (Decodable) -> T?,
                               completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIManager: APIManagerProtocol {
    func fetchData<T>(_ route: ServerEndpoint, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        serverRouter.request(route, decode: { json -> T? in
            guard let results = json as? T else { return  nil }
            return results
        }, completion: completion)
    }
}
