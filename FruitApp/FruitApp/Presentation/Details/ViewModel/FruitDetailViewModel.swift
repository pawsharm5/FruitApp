//
//  FruitDetailViewModel.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation

protocol FruitDetailViewModelProtocol {
    var fruitId: String { get }
    var allFruitResponse: Observable<FruitsListModelElement?> { get }
    var errorMessage: Observable<String?>  { get }
    func getFruitDetails()
    func getFruitData() -> FruitsListModelElement?
}

final class FruitDetailViewModel: FruitDetailViewModelProtocol {
    private let useCase: DetailUseCase
    private let navigator: FruitDetailsNavigatorProtocol
    var fruitId: String
    var allFruitResponse: Observable<FruitsListModelElement?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    
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
