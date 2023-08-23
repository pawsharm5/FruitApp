//
//  FruitDetailViewTest.swift
//  FruitAppTests
//
//  Created by Pawan Sharma on 22/08/23.
//

import XCTest
@testable import FruitApp

class FakeDetailViewNavigator:FruitDetailsNavigatorProtocol {
    
}

final class FruitDetailViewTest: XCTestCase {
    var sut:FruitDetailsViewController!
    
    var mokeBlankFruitArray = [FruitsListModelElement(name: nil,id: nil,family:nil,order: nil,genus: nil,nutritions: Nutritions(calories: nil,fat: nil,sugar: nil,carbohydrates: nil,protein: nil))]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true //For testing only
        self.sut = self.makeSUT()
        _ = sut.view
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func makeSUT() -> FruitDetailsViewController {
        let destination = StoryboardScene.Main.fruitDetails.instantiate { coder in
            let dependacies = DependenciesAllocator.allocate()
            let viewModel = FruitDetailViewModel(navigator: FakeDetailViewNavigator(), useCase: DetailUseCase(repo: Repository(service: Services(apiManager: dependacies.apiManager), mapper: FruitsListMapper())), fruitId: "52")
            return FruitDetailsViewController(coder: coder, viewModel: viewModel)
        }
        destination.loadViewIfNeeded()
        return destination
    }
    
    func testBlankData() {
        self.sut.viewDidLoad()
    }
    
    func testBackButton() {
        self.sut.navigationController?.popViewController(animated: true)
    }
}
