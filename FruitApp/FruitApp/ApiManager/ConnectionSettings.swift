//
//  ConnectionSettings.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import Foundation
import Alamofire

struct ConnectionSettings { }

extension ConnectionSettings {
    static func sessionManager() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        let sessionManager = Session(configuration: configuration, startRequestsImmediately: false)
        return sessionManager
    }
}
