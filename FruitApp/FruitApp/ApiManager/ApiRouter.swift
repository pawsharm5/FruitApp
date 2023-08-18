//
//  ApiRouter.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import Foundation
import Alamofire
enum APIRouter {
    
    // MARK: - Endpoints
    case getAllFruit
    
    var baseURL: String {
        return AppEnvironement.baseURL.absoluteString
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllFruit: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAllFruit:
            return "fruit/all"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default: return URLEncoding.default
        }
    }
    
    var paramters: Parameters? {
        switch self {
        case .getAllFruit: return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        case .getAllFruit: return nil
        }
    }
    
    /* future use if any
    var additionalHeaders: HTTPHeaders? {
        switch self {
        case .getAllFruit: return nil
        case .addNewFruit: return nil
        }
    }
    */
    var timeout: TimeInterval {
        switch self {
        default: return 20
        }
    }
}

enum AppEnvironement {
    case production
    case development
}

extension AppEnvironement {
    static var currentState: AppEnvironement {
        return .development
    }
}

//swiftlint:disable force_unwrapping
extension AppEnvironement {
    static var baseURL: URL {
        switch AppEnvironement.currentState {
        case .production:
            return URL(string: Servers.production)!
        case .development:
            return URL(string: Servers.development)!
        }
    }
}

struct Servers {
    /** In Real World: Change this later to production url */
    static let production = "https://www.fruityvice.com/api/"
    static let development = "https://www.fruityvice.com/api/"
}
