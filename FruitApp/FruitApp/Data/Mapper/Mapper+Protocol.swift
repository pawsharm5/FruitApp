//
//  Mapper+Protocol.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
protocol BaseMappper {
    func fromDataToDomainModel(dataModel: [BaseDataModel]) -> BaseDomainModel?
}
