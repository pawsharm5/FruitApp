//
//  FruitListDataModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 22/08/23.
//

import Foundation
// MARK: - FruitListDataModel
struct FruitsListModelElement: BaseDataModel {
    let name: String?
    let id: Int?
    let family, order, genus: String?
    let nutritions: Nutritions?
}

// MARK: - Nutritions
struct Nutritions: Codable {
    let calories: Int?
    let fat, sugar, carbohydrates, protein: Double?
}

typealias FruitListDataModel = [FruitsListModelElement]
