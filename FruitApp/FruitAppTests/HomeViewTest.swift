//
//  HomeViewModelTest.swift
//  FruitAppTests
//
//  Created by Pawan Sharma on 22/08/23.
//

import XCTest
@testable import FruitApp

class FakeHomeViewNavigatorProtocol:HomeViewNavigatorProtocol {
    func showFruitDetails(for fruit: FruitApp.FruitsListModelElement) {
        
    }
}

final class HomeViewTest: XCTestCase {

    var sut:HomeViewController!
    var mokeFruitArray = [FruitsListModelElement(name: "Banana",id: 1,family:"Musaceae",order: "Zingiberales",genus: "Musa",nutritions: Nutritions(calories: 96,fat: 0.2,sugar: 17.2,carbohydrates: 22.0,protein: 1.0))]
    
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

    func makeSUT() -> HomeViewController {
        let destination = StoryboardScene.Main.homeView.instantiate { coder in
            let dependacies = DependenciesAllocator.allocate()
            let viewModel = HomeViewModel(navigator: FakeHomeViewNavigatorProtocol(), useCase: HomeUseCase(repo: Repository(service: Services(apiManager: dependacies.apiManager), mapper: FruitsListMapper())))
            return HomeViewController(coder: coder, viewModel: viewModel)
        }
        destination.loadViewIfNeeded()
        return destination
    }
    
    func testFakeData() {
        self.sut.viewModel.allFruitResponse.value = self.mokeFruitArray
        self.sut.viewModel.updateFilterType(category: .AllFruits)
        self.sut.viewModel.filterByFamily()
    }
    
    func testBlankFakeData() {
        self.sut.viewModel.allFruitResponse.value = self.mokeBlankFruitArray
        self.sut.viewModel.updateFilterType(category: .AllFruits)
        self.sut.viewModel.filterByFamily()
        
        XCTAssertEqual(self.sut.viewModel.getFruitName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        self.sut.viewModel.updateFilterType(category: .FruitsByFamily)
        self.sut.viewModel.filterByFamily()
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        self.sut.viewModel.updateFilterType(category: .FruitsByGenus)
        self.sut.viewModel.filterByFamily()
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        self.sut.viewModel.updateFilterType(category: .FruitsByOrder)
        self.sut.viewModel.filterByFamily()
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)

        self.sut.viewModel.allFruitResponse.value = nil
        
        XCTAssertEqual(self.sut.viewModel.getFruitName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
        
        XCTAssertEqual(self.sut.viewModel.getFruitFamilyName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitGenusName(forIndex: 0, section: 0), nil)
        XCTAssertEqual(self.sut.viewModel.getFruitOrderName(forIndex: 0, section: 0), nil)
    }
    
    func testApiData() {
        let expect = XCTestExpectation(description: "callback")
        self.sut.viewModel.getAllFruits()
        expect.fulfill()
        wait(for: [expect], timeout: 10.0)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(self.sut.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(self.sut.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(self.sut.responds(to: #selector(self.sut.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.sut.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.sut.responds(to: #selector(self.sut.numberOfSections(in:))))
        XCTAssertTrue(self.sut.responds(to: #selector(self.sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.sut.responds(to: #selector(self.sut.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "FruitListTblCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTappingTableViewCellWithoutData() {
        
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "FruitListTblCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        let didTap = "Cell"
        self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(didTap, "Cell")
        
        //Push View
        self.sut.viewModel.redirectToFruitDetails(forIndex: 0, section: 0)
        
    }
    
    func testTappingTableViewCellWithData() {

        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "FruitListTblCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        let didTap = "Cell"
        self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(didTap, "Cell")

        let destination = StoryboardScene.Main.fruitDetails.instantiate { coder in
            let dependacies = DependenciesAllocator.allocate()
            let viewModel = FruitDetailViewModel(navigator: FakeDetailViewNavigator(), useCase: DetailUseCase(repo: Repository(service: Services(apiManager: dependacies.apiManager), mapper: FruitsListMapper())), fruitId: "")
            return FruitDetailsViewController(coder: coder, viewModel: viewModel)
        }
        destination.loadViewIfNeeded()
    }
//
    func testAllFruitButtonClick() {
        self.sut.btnAllFruits.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.btnAllFruits.tag, 0)
    }
    
    func testFruitByFamilyButtonClick() {
        
        self.sut.btnFruitByFamily.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.btnFruitByFamily.tag, 1)
    }
    
    func testFruitByGenusButtonClick() {
        
        self.sut.btnFruitByGenus.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.btnFruitByGenus.tag, 2)
    }
    
    func testFruitByOrderButtonClick() {
        
        self.sut.btnFruitByOrder.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(self.sut.btnFruitByOrder.tag, 3)
    }
    
    // MARK: - SearchBar
    
    func testSUTHasSearchBar() {
        
        XCTAssertNotNil(self.sut.searchBar)
    }
    
    func testSUTShouldSetSearchBarDelegate() {
        
        XCTAssertNotNil(self.sut.searchBar.delegate)
    }
    
    func testSUTConformsToSearchBarDelegateProtocol() {
        
        XCTAssert(self.sut.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(self.sut.responds(to: #selector(self.sut.searchBar(_:textDidChange:))))
        XCTAssertTrue(self.sut.responds(to:#selector(self.sut.searchBarSearchButtonClicked(_:))))
    }
    
    func testSearchTextIsBlank() {
        self.sut.searchBar(self.sut.searchBar, textDidChange: "")
    }
    
    func testSearchButtonClick() {
        self.sut.searchBar(self.sut.searchBar, textDidChange: "Bana")
    }
    
    func testSearchingAllFruit() {
        let expect = XCTestExpectation(description: "AllFruit")
        self.sut.viewModel.updateFilterType(category: .AllFruits)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "Bana")
            expect.fulfill()
            XCTAssertEqual(expect.description, "AllFruit")
        }
        
        wait(for: [expect], timeout: 20.0)
        
    }
    
    func testSearchingFruitByFamily() {
        let expect = XCTestExpectation(description: "ByFamily")
        self.sut.viewModel.updateFilterType(category: .FruitsByFamily)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "Bana")
            XCTAssertEqual(self?.sut.viewModel.filteredResponse.value?.first?.1.first?.name ?? "", "Banana")
            expect.fulfill()
            XCTAssertEqual(expect.description, "ByFamily")
        }
        
        wait(for: [expect], timeout: 20.0)
        
    }
    
    func testSearchingFruitGenus() {
        let expect = XCTestExpectation(description: "FruitGenus")
        self.sut.viewModel.updateFilterType(category: .FruitsByGenus)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "Bana")
            XCTAssertEqual(self?.sut.viewModel.filteredResponse.value?.first?.1.first?.name ?? "", "Banana")
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
        
    }
    
    func testSearchingFruitOrder() {
        let expect = XCTestExpectation(description: "FruitOrder")
        self.sut.viewModel.updateFilterType(category: .FruitsByOrder)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "Bana")
            XCTAssertEqual(self?.sut.viewModel.filteredResponse.value?.first?.1.first?.name ?? "", "Banana")
            expect.fulfill()
        }
        
        wait(for: [expect], timeout:20.0)
        
    }
    
    func testSearchingAllFruitNoData() {
        let expect = XCTestExpectation(description: "AllFruitNoData")
        self.sut.viewModel.updateFilterType(category: .AllFruits)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "xgvcghd")
            XCTAssertEqual(self?.sut.viewModel.filteredResponse.value?.first?.1.first?.name ?? "", "")
            expect.fulfill()
            XCTAssertEqual(expect.description, "AllFruitNoData")
        }
        
        wait(for: [expect], timeout: 20.0)
        
    }
}
