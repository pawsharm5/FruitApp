//
//  FruitsListMapper.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation

final class FruitsListMapper: BaseMappper{
    func fromDataToDomainModel(dataModel: [BaseDataModel]) -> BaseDomainModel? {
        var domainObj: BaseDomainModel?
        let model = dataModel as? FruitListDataModel
        
        if let modelObj = model {
            domainObj =  getAllFruits(result: modelObj)
        }
       
        return domainObj
    }

    func getAllFruits(result: FruitListDataModel) -> FruitListDomainModel? {
        var list = [FruitsListModelElement]()
        list.append(contentsOf: result)
        return FruitListDomainModel(count: list.count, results: list)
    }
}
