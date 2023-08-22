//
//  HomeViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    var apiManager: APIManagerProtocol
    
    private let navigator: HomeViewNavigatorProtocol?
    
    var allFruitResponse: Observable<[FruitsListModelElement]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    var filteredResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)
    var searchResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)

    var selectdCategory = Category.AllFruits
    var soretedKeys = [String]()
    
    init(apiManager: APIManagerProtocol, navigator: HomeViewNavigatorProtocol) {
        self.apiManager = apiManager
        self.navigator = navigator
    }
    
    func getAllFruits() {
        apiManager.getAllFruits(completion: { [weak self] result in
            switch result {
            case .success(let listModel):
                guard let model = listModel else { return }
                self?.allFruitResponse.value = model
                self?.filterByFamily(type: .AllFruits)
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    func filterByFamily(type:Category) {
        if let dataV = self.allFruitResponse.value {
            let valueData = Dictionary(grouping: dataV)  { (fruit) -> String in
                switch type {
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
        }
    }
    
    func getFruitAt(forIndex index: Int, section: Int) -> FruitsListModelElement? {
        return self.filteredResponse.value?[section].1[index]
    }
    
    func redirectToFruitDetails(forIndex index: Int, section: Int) {
        if let fruitValue = self.filteredResponse.value?[section].1[index] {
            navigator?.showFruitDetails(for: fruitValue)
        }
    }
    
    func getFruitName(forIndex index: Int, section: Int) -> String? {
        if let fruitValue = self.filteredResponse.value?[section].1[index] {
            return fruitValue.name ?? ""
        }
        return ""
    }
    
    func getFruitFamilyName(forIndex index: Int, section: Int, type: Category) -> String? {
        if let fruitValue = self.filteredResponse.value?[section].1[index] {
            return type == .AllFruits ? "" : fruitValue.family ?? ""
        }
        return ""
    }
    
    func getFruitGenusName(forIndex index: Int, section: Int, type: Category) -> String? {
        if let fruitValue = self.filteredResponse.value?[section].1[index] {
            return type == .AllFruits ? "" : fruitValue.genus ?? ""
        }
        return ""
    }
    
    func getFruitOrderName(forIndex index: Int, section: Int, type: Category) -> String? {
        if let fruitValue = self.filteredResponse.value?[section].1[index] {
            return type == .AllFruits ? "" : fruitValue.order ?? ""
        }
        return ""
    }

}

