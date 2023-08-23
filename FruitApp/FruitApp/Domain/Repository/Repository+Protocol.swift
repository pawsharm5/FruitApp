//
//  Repository+Protocol.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation

protocol RepositoryInferface {
    var service: ServiceInterface {get}
    var mapper: BaseMappper {get set}
    
    func getAllFruits(_ completion: @escaping (FruitListDomainModel?) -> Void, failure:@escaping(Error) -> Void)
    
    func getFruitDetails(fruitId:String, _ completion: @escaping (Result<FruitsListModelElement?, APIError>) -> Void)
}
