//
//  HomeViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var allFruitResponse: Observable<[FruitsListModelElement]?> { get }
    var errorMessage: Observable<String?> { get }
    var filteredResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> { get }
    var searchResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> { get }
    var selectdCategory: Category { get set }
    func updateFilterType(category :Category)
    func getAllFruits()
    func filterByFamily()
    func searchFruit(searchText:String)
    func getFruitAt(forIndex index: Int, section: Int) -> FruitsListModelElement?
    func redirectToFruitDetails(forIndex index: Int, section: Int)
    func getFruitName(forIndex index: Int, section: Int) -> String?
    func getFruitFamilyName(forIndex index: Int, section: Int) -> String?
    func getFruitGenusName(forIndex index: Int, section: Int) -> String?
    func getFruitOrderName(forIndex index: Int, section: Int) -> String?
}

final class HomeViewModel: HomeViewModelProtocol {
    
     private let useCase: HomeUseCase
     private let navigator: HomeViewNavigatorProtocol
    
     var allFruitResponse: Observable<[FruitsListModelElement]?> = Observable(nil)
     var errorMessage: Observable<String?> = Observable(nil)
     var filteredResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)
     var searchResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)

     var selectdCategory = Category.AllFruits
    
    init(navigator: HomeViewNavigatorProtocol, useCase: HomeUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func updateFilterType(category :Category) {
        self.selectdCategory = category
    }
    
    func getAllFruits() {
        self.useCase.getAllFruits({ listModel in
            guard let model = listModel else { return }
            self.allFruitResponse.value = model.results
            self.filterByFamily()
        }, failure: { error in
            self.errorMessage.value = error.localizedDescription
        })
    }
    
    func filterByFamily() {
        if let dataV = self.allFruitResponse.value {
            let valueData = Dictionary(grouping: dataV)  { (fruit) -> String in
                switch self.selectdCategory {
                case .AllFruits:
                    return "All Fruits"
                case .FruitsByFamily:
                    return fruit.family ?? ""
                case .FruitsByGenus:
                    return fruit.genus ?? ""
                case .FruitsByOrder:
                    return fruit.order ?? ""
                }
            }
            self.filteredResponse.value = Array(valueData).sorted(by: {$0.key < $1.key})
        }
    }
    
    func searchFruit(searchText:String) {
        if let dataV = self.allFruitResponse.value?.filter({($0.name ?? "").contains(searchText)}) {
            let valueData = Dictionary(grouping: dataV)  { (fruit) -> String in
                switch self.selectdCategory {
                case .AllFruits:
                    return "All Fruits"
                case .FruitsByFamily:
                    return fruit.family ?? ""
                case .FruitsByGenus:
                    return fruit.genus ?? ""
                case .FruitsByOrder:
                    return fruit.order ?? ""
                }
            }
            self.filteredResponse.value = Array(valueData).sorted(by: {$0.key < $1.key})
        } else {
            self.errorMessage.value = APIError.requestFailed(description: "No Data Found").localizedDescription
        }
    }
    
    func getFruitAt(forIndex index: Int, section: Int) -> FruitsListModelElement? {
        let fruitValue = self.filteredResponse.value?[section].1[index]
        return fruitValue
    }
    
    func redirectToFruitDetails(forIndex index: Int, section: Int) {
        if let fruitValue = self.getFruitAt(forIndex: index, section: section) {
            navigator.showFruitDetails(for: fruitValue)
        }
    }
    
    func getFruitName(forIndex index: Int, section: Int) -> String? {
        let fruitValue = self.filteredResponse.value?[section].1[index]
        return fruitValue?.name
    }
    
    func getFruitFamilyName(forIndex index: Int, section: Int) -> String? {
        let fruitValue = self.filteredResponse.value?[section].1[index]
        return fruitValue?.family
    }
    
    func getFruitGenusName(forIndex index: Int, section: Int) -> String? {
        let fruitValue = self.filteredResponse.value?[section].1[index]
        return fruitValue?.genus
    }
    
    func getFruitOrderName(forIndex index: Int, section: Int) -> String? {
        let fruitValue = self.filteredResponse.value?[section].1[index]
        return fruitValue?.order
    }

}


