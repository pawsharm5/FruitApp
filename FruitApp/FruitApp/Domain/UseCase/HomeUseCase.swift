//
//  HomeUseCase.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
final class HomeUseCase {
    private var repository: RepositoryInferface
    
    init(repo:RepositoryInferface) {
        self.repository = repo
    }
    
    func getAllFruits(_ completion: @escaping (FruitListDomainModel?) -> Void, failure:@escaping(Error) -> Void) {
        self.repository.mapper = FruitsListMapper()
        repository.getAllFruits({ model in
            completion(model)
        }, failure: { error in
            failure(error)
        })
    }
}
