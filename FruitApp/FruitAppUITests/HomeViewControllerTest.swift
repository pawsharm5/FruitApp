////
////  HomeViewControllerTest.swift
////  FruitAppUITests
////
////  Created by Pawan Sharma on 16/08/23.
////
//
//import Foundation
//import XCTest
//@testable import FruitApp
//final class HomeViewControllerTest: XCTestCase {
//    
//    let app = XCUIApplication()
//    var viewController: HomeViewController!
//    override func setUp() {
//        super.setUp()
//        app.launch()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        self.viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        
//        // in view controller, menuItems = ["one", "two", "three"]
//        self.viewController.loadView()
//        self.viewController.viewDidLoad()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//    
//    func testHasATableView() {
//        XCTAssertNotNil(self.viewController.tableView)
//    }
//    
//    func testTableViewHasDelegate() {
//        XCTAssertNotNil(self.viewController.tableView.delegate)
//    }
//    
//    func testTableViewConfromsToTableViewDelegateProtocol() {
//        XCTAssertTrue(self.viewController.conforms(to: UITableViewDelegate.self))
//        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.tableView(_:didSelectRowAt:))))
//    }
//    
//    func testTableViewHasDataSource() {
//        XCTAssertNotNil(viewController.tableView.dataSource)
//    }
//    
//    func testTableViewConformsToTableViewDataSourceProtocol() {
//        XCTAssertTrue(self.viewController.conforms(to: UITableViewDataSource.self))
//        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.numberOfSections(in:))))
//        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.tableView(_:numberOfRowsInSection:))))
//        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.tableView(_:cellForRowAt:))))
//    }
//    
//    func testTableViewCellHasReuseIdentifier() {
//        let cell = self.viewController.tableView(self.viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
//        let actualReuseIdentifer = cell?.reuseIdentifier
//        let expectedReuseIdentifier = "FruitListTblCell"
//        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
//    }
//    
//    func testTableCellHasCorrectLabelText() {
//        let cell0 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FruitListTblCell
//        XCTAssertEqual(cell0?.LabelFruitName.text, "one")
//        
//        let cell1 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? FruitListTblCell
//        XCTAssertEqual(cell1?.LabelFruitName.text, "two")
//        
//        let cell2 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? FruitListTblCell
//        XCTAssertEqual(cell2?.LabelFruitName.text, "three")
//    }
//}
