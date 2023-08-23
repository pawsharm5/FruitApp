//
//  GenrateAPI.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let serverURL = "SERVER_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("*** Plist file not found ***")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let serverURL: String = {
        guard let serverURLstring = Environment.infoDictionary[Keys.Plist.serverURL] as? String,
              serverURLstring.count > 0 else {
            fatalError("*** Server URL not set in plist for this environment ***")
        }
        return serverURLstring
    }()
}


enum ChooseOperator {
    static let and = "&"
    static let questionMark = "?"
}

enum GenerateAPI {
    static let scheme = "https://"
    static let urlPath = "/api/"
    static let queryParam = ""
}
