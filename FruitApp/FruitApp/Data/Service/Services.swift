//
//  Service.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation

final class Services: ServiceInterface {
    internal var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getAllFruits(_ completion: @escaping (Result<FruitListDataModel?, APIError>) -> Void) {
        apiManager.fetchData(.getAllFruits, decode: { json -> FruitListDataModel? in
            guard let results = json as? FruitListDataModel else { return  nil }
            return results
        }, completion: completion)
    }
    
    func getFruitDetails(id: String, _ completion: @escaping (Result<FruitsListModelElement?, APIError>) -> Void) {
        apiManager.fetchData(.getFruitDetails(id: id), decode: { json -> FruitsListModelElement? in
            guard let results = json as? FruitsListModelElement else { return  nil }
            return results
        }, completion: completion)
    }
}
