//
//  FruitListDataModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
// MARK: - FruitListDataModel
struct FruitsListModelElement: BaseDataModel {
    var name: String?
    var id: Int?
    var family, order, genus: String?
    var nutritions: Nutritions?
}

// MARK: - Nutritions
struct Nutritions: Codable {
    var calories: Int?
    var fat, sugar, carbohydrates, protein: Double?
}

typealias FruitListDataModel = [FruitsListModelElement]
