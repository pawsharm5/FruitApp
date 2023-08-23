//
//  Service+Protocol.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation

protocol ServiceInterface {
    var apiManager: APIManagerProtocol {get set}
    func getAllFruits(_ completion: @escaping (Result<FruitListDataModel?, APIError>) -> Void)
    func getFruitDetails(id: String, _ completion: @escaping (Result<FruitsListModelElement?, APIError>) -> Void)
}
