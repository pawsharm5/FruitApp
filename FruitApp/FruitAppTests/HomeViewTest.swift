//
//  HomeViewTest.swift
//  FruitAppTests
//
//  Created by Pawan Sharma on 17/08/23.
//

import XCTest
@testable import FruitApp
final class HomeViewTest: XCTestCase {
    
    var sut:HomeViewController!
    var mokeFruitArray = [FruitsListModelElement(name: "Banana",id: 1,family:"Musaceae",order: "Zingiberales",genus: "Musa",nutritions: Nutritions(calories: 96,fat: 0.2,sugar: 17.2,carbohydrates: 22.0,protein: 1.0))]

    
    override func setUp() {
        super.setUp()
        self.sut = self.makeSUT()
        _ = sut.view
        continueAfterFailure = true
    }
    
    override func tearDown() {
        super.tearDown() //its get call all time whenever any case we check
    }
    
    func makeSUT() -> HomeViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let sutV:HomeViewController = storyboard.instantiateViewController()
        sutV.loadViewIfNeeded()
        return sutV
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
    
    func testAllFruitButtonClick() {
        self.sut.btnAllFruits.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(self.sut.viewModel.selectdCategory, .AllFruits)
    }
    
    func testFruitByFamilyButtonClick() {
        
        self.sut.btnFruitByFamily.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.btnFruitByFamily.tag, 1)
    }
    
    func testFruitByGenusButtonClick() {
        
        self.sut.btnFruitByGenus.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.viewModel.selectdCategory, .FruitsByGenus)
    }
    
    func testFruitByOrderButtonClick() {
        
        self.sut.btnFruitByOrder.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(self.sut.btnFruitByOrder.tag, 3)
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
        let storyboard = UIStoryboard(storyboard: .Main)
        let sutDetail:FruitDetailsViewController = storyboard.instantiateViewController()
        sutDetail.loadViewIfNeeded()
        sutDetail.viewModel.fruitData = FruitsListModelElement(name: nil,id: nil,family:nil,order: "Zingiberales",genus: nil,nutritions: Nutritions(calories: nil,fat: nil,sugar: nil,carbohydrates: nil,protein: nil))
        self.sut.navigationController?.pushViewController(sutDetail, animated: true)
        
    }
    
    
    func testTappingTableViewCellWithData() {
        
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "FruitListTblCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        let didTap = "Cell"
        self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(didTap, "Cell")
        
        //Push View
        let storyboard = UIStoryboard(storyboard: .Main)
        let sutDetail:FruitDetailsViewController = storyboard.instantiateViewController()
        sutDetail.loadViewIfNeeded()
        sutDetail.viewModel.fruitData = FruitsListModelElement(name: "Banana",id: 1,family:"Musaceae",order: "Zingiberales",genus: "Musa",nutritions: Nutritions(calories: 96,fat: 0.2,sugar: 17.2,carbohydrates: 22.0,protein: 1.0))
        self.sut.navigationController?.pushViewController(sutDetail, animated: true)
        
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
    
    func testSearching() {
        let expect = XCTestExpectation(description: "callback")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.sut.searchBar((self?.sut.searchBar)!, textDidChange: "Bana")
            self?.sut.viewModel.selectdCategory = .AllFruits
            XCTAssertEqual(self?.sut.viewModel.filteredResponse.value?.first?.1.first?.name ?? "", "Banana")
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
        
    }
}
