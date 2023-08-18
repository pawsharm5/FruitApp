//
//  HomeViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation
import Combine
import Alamofire
import PromiseKit

class HomeViewModel: ObservableObject {
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    var allFruitResponse: Observable<[FruitsListModelElement]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    var filteredResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)
    var searchResponse: Observable<Array<(String, Array<FruitsListModelElement>)>?> = Observable(nil)

    enum Category {
        case AllFruits
        case FruitsByFamily
        case FruitsByGenus
        case FruitsByOrder
    }
    
    var selectdCategory = Category.AllFruits
    var soretedKeys = [String]()
    
    func getAllFruits() {
        let apiRouterStructure = APIRouterStructer(apiRouter: .getAllFruit)
        let todosPromise: Promise<FruitsListModel> = session.request(apiRouterStructure)
        firstly {
            todosPromise
        }.then { [weak self] fruits -> Promise<FruitsListModel> in
            guard let self = self else { throw InternalError.unexpected }
            self.allFruitResponse.value = fruits
            return Promise<FruitsListModel>.value(fruits)
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.errorMessage.value = error.localizedDescription
        }
        .finally {
            self.filterByFamily(type: .AllFruits)
        }
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
}

