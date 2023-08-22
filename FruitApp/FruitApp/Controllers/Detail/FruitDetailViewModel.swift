//
//  FruitDetailViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation

class FruitDetailViewModel: FruitDetailsViewModelProtocol {
    
    private let apiManager: APIManagerProtocol
    private let navigator: FruitDetailsNavigatorProtocol
    private var fruitData: FruitsListModelElement
    
    init(apiManager: APIManagerProtocol, navigator: FruitDetailsNavigatorProtocol, fruitData: FruitsListModelElement) {
        self.apiManager = apiManager
        self.navigator = navigator
        self.fruitData = fruitData
    }
    
    func getFruitData() -> FruitsListModelElement? {
        return fruitData
    }
}
