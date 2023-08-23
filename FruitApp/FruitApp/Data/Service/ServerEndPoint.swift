//
//  ServerEndPoint.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

enum ServerEndpoint {
    case getAllFruits
    case getFruitDetails(id: String)
}

extension ServerEndpoint: EndPointType {
    /// scheme will be https
    var scheme: String { "https" }
    /// base URL
    var baseURL: String { Environment.serverURL }
    /// api path
    private var middlePath: String { "/api/fruit/" }
    
    /// URL Path
    var path: String {
        switch self {
        
        case .getAllFruits:
            return middlePath + "all"
        case .getFruitDetails(let id):
            return middlePath + "\(id)"
        }
    }
    
    /// request method type
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllFruits:
               return .get
        case .getFruitDetails:
            return .get
        }
    }
    /// parameters passing
    var parameters: [URLQueryItem]? { nil }
    /// Header params
    var headers: [HTTPHeader]? {
        return [HTTPHeader.content("application/json")]
    }
    /// data (body) passing as params
    var data: Data? {
        switch self {
        
        case .getAllFruits:
            return nil
        case .getFruitDetails:
            return nil
        }
    }
}
