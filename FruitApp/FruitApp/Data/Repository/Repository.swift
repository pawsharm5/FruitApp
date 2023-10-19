//
//  Repository.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
final class Repository: RepositoryInferface {
    
    let service: ServiceInterface
    var mapper: BaseMappper
    
    
    init(service: ServiceInterface, mapper: BaseMappper) {
        self.service = service
        self.mapper = mapper
    }
    
    func getAllFruits(_ completion: @escaping (FruitListDomainModel?) -> Void, failure:@escaping(Error) -> Void) {
        self.service.getAllFruits() { resultV in
            switch resultV {
            case .success(let model):
                let mapData = self.mapper.fromDataToDomainModel(dataModel: (model)!)
                completion(mapData as? FruitListDomainModel)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getFruitDetails(fruitId: String, _ completion: @escaping (Result<FruitsListModelElement?, APIError>) -> Void) {
        self.service.getFruitDetails(id: fruitId, completion)
    }
}
