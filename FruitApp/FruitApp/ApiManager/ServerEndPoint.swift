//
//  ServerEndPoint.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

enum ServerEndpoint {
    /// User
    case getAllFruits

}

extension ServerEndpoint: EndPointType {
    /// scheme will be https
    var scheme: String { "https" }
    /// base URL
    var baseURL: String { Environment.serverURL }
    /// api path
    private var middlePath: String { "/api/fruit/all" }
    
    /// URL Path
    var path: String {
        return middlePath
    }
    
    /// request method type
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllFruits:
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
        }
    }
}
