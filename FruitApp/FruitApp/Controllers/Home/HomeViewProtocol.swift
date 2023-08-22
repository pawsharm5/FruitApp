//
//  HomeViewProtocol.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation

protocol HomeViewModelProtocol {
    var apiManager:APIManagerProtocol { get set }
    var allFruitResponse: Observable<[FruitsListModelElement]?> { get set }
    var errorMessage: Observable<String?> { get set }
    var filteredResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> { get set }
    var searchResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> { get set }
    var selectdCategory:Category {get set}
    func getAllFruits()
    func filterByFamily(type:Category)
    func getFruitAt(forIndex index: Int, section:Int) -> FruitsListModelElement?
    func searchFruit(searchText:String)
    func redirectToFruitDetails(forIndex index: Int, section:Int)
    func getFruitName(forIndex index:Int, section:Int) -> String?
    func getFruitFamilyName(forIndex index:Int, section:Int) -> String?
    func getFruitGenusName(forIndex index:Int, section:Int) -> String?
    func getFruitOrderName(forIndex index:Int, section:Int) -> String?
}

protocol HomeViewNavigatorProtocol {
    func showFruitDetails(for fruit: FruitsListModelElement)
}

enum HomeViewUIUpdateCase {
    case success(model: FruitsListModel)
    case error(error: APIError)
}

enum Category:CaseIterable {
    case AllFruits
    case FruitsByFamily
    case FruitsByGenus
    case FruitsByOrder
}
