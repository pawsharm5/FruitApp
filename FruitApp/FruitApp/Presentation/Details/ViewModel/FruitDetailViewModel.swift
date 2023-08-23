//
//  FruitDetailViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation

protocol FruitDetailViewModelProtocol: AnyObject {
    var useCase: DetailUseCase { get set }
    var navigator: FruitDetailsNavigatorProtocol { get set }
    var fruitId: String { get set }
    var allFruitResponse: Observable<FruitsListModelElement?> {get set}
    var errorMessage: Observable<String?> {get set}
    func getFruitDetails()
    func getFruitData() -> FruitsListModelElement?
}

class FruitDetailViewModel: ObservableObject,FruitDetailViewModelProtocol {
    internal var useCase: DetailUseCase
    internal var navigator: FruitDetailsNavigatorProtocol
    internal var fruitId: String
    internal var allFruitResponse: Observable<FruitsListModelElement?> = Observable(nil)
    internal var errorMessage: Observable<String?> = Observable(nil)
    
    init(navigator: FruitDetailsNavigatorProtocol, useCase: DetailUseCase, fruitId: String) {
        self.useCase = useCase
        self.navigator = navigator
        self.fruitId = fruitId
    }
    
    func getFruitDetails() {
        self.useCase.getFruitDetails(fruitId: self.fruitId, completion: { [weak self] result in
            switch result {
            case .success(let listModel):
                guard let model = listModel else { return }
                self?.allFruitResponse.value = model
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    func getFruitData() -> FruitsListModelElement? {
        return self.allFruitResponse.value
    }
}
