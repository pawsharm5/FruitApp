//
//  HomeViewUITest.swift
//  FruitAppUITests
//
//  Created by Pawan Sharma on 17/08/23.
//

import XCTest

final class HomeViewUITest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let fruitsByFamilyStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Fruits By Family"]/*[[".buttons[\"Fruits By Family\"].staticTexts[\"Fruits By Family\"]",".staticTexts[\"Fruits By Family\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fruitsByFamilyStaticText.tap()
        
        let fruitsByGenusStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Fruits By Genus"]/*[[".buttons[\"Fruits By Genus\"].staticTexts[\"Fruits By Genus\"]",".staticTexts[\"Fruits By Genus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fruitsByGenusStaticText.tap()
        
        let fruitsByOrderStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Fruits By Order"]/*[[".buttons[\"Fruits By Order\"].staticTexts[\"Fruits By Order\"]",".staticTexts[\"Fruits By Order\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fruitsByOrderStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["All Fruits"]/*[[".buttons[\"All Fruits\"].staticTexts[\"All Fruits\"]",".staticTexts[\"All Fruits\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Persimmon"]/*[[".cells[\"Cell_0\"].staticTexts[\"Persimmon\"]",".staticTexts[\"Persimmon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let welcomeToFruitsAppButton = app.navigationBars["Welcome to Fruits App"].buttons["Welcome to Fruits App"]
        welcomeToFruitsAppButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blackberry"]/*[[".cells[\"Cell_6\"].staticTexts[\"Blackberry\"]",".staticTexts[\"Blackberry\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        welcomeToFruitsAppButton.tap()
        fruitsByFamilyStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Dragonfruit"]/*[[".cells.matching(identifier: \"Cell_1\").staticTexts[\"Dragonfruit\"]",".staticTexts[\"Dragonfruit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        welcomeToFruitsAppButton.tap()
        fruitsByGenusStaticText.tap()
        fruitsByOrderStaticText.tap()
        fruitsByFamilyStaticText.tap()
        
        let searchFruitsSearchField = app.searchFields["Search Fruits"]
        searchFruitsSearchField.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Kiwi"]/*[[".cells.matching(identifier: \"Cell_0\").staticTexts[\"Kiwi\"]",".staticTexts[\"Kiwi\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        welcomeToFruitsAppButton.tap()
        searchFruitsSearchField.tap()
//        searchFruitsSearchField.buttons["Clear text"].tap()
        tablesQuery.staticTexts["Bromeliaceae"].swipeUp()
        tablesQuery.staticTexts["Caricaceae"].swipeDown()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //Screen recording
        
    }
}
