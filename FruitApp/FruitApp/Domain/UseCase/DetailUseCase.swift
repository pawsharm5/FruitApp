//
//  DetailUseCase.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
final class DetailUseCase {
    private var repository: RepositoryInferface
    
    init(repo:RepositoryInferface) {
        self.repository = repo
    }
    
    func getFruitDetails(fruitId: String, completion: @escaping (Result<FruitsListModelElement?, APIError>) -> Void) {
        self.repository.mapper = FruitsListMapper()
        repository.getFruitDetails(fruitId: fruitId, completion)
    }
}
