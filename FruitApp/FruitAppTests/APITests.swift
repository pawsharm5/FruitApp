//
//  ApiTest.swift
//  FruitAppTests
//
//  Created by Pawan Sharma on 16/08/23.
//

import Foundation
import XCTest
import Alamofire
import PromiseKit
@testable import FruitApp

class APITests: XCTestCase {
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    var apiCall: APIRouterStructer?
    var fruitsValues:[FruitsListModelElement]?
    var filteredResponse1:Array<(String, Array<FruitsListModelElement>)>?
    var filteredResponse2:Array<(String, Array<FruitsListModelElement>)>?
    var filteredResponse3:Array<(String, Array<FruitsListModelElement>)>?
    var filteredResponse4:Array<(String, Array<FruitsListModelElement>)>?
    
    enum Category {
        case AllFruits
        case FruitsByFamily
        case FruitsByGenus
        case FruitsByOrder
    }
    
       var mokeFruitArray = [FruitsListModelElement(name: "Banana",id: 1,family:"Musaceae",order: "Zingiberales",genus: "Musa",nutritions: Nutritions(calories: 96,fat: 0.2,sugar: 17.2,carbohydrates: 22.0,protein: 1.0))]
    let object = """
{"name":"Banana","id":1,"family":"Musaceae","order":"Zingiberales","genus":"Musa","nutritions":{"calories":96.0,"fat":0.2,"sugar":17.2,"carbohydrates":22.0,"protein":1}}
""".data(using: .utf8)
            
    override func setUp() {
        super.setUp()
        apiCall = APIRouterStructer(apiRouter: .getAllFruit)
    }
    
    override func tearDown() {
        apiCall = nil
        super.tearDown() //its get call all time whenever any case we check
    }
    
    func test_Fail_To_Parse_Response() {
        let sut = self.apiCall
        XCTAssertEqual(sut?.urlRequest?.url?.absoluteString ?? "", "https://www.fruityvice.com/api/fruit/all") //Check URL is correct
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        let todosPromise: Promise<FruitsListModel> = session.request(sut!)
        firstly {
            todosPromise
        }.then { [weak self] fruits -> Promise<FruitsListModel> in
            guard let self = self else { throw InternalError.unexpected }
            //XCTAssertEqual( fruits.count, 20)
            XCTAssertEqual( fruits.count, 42) //Check total counts are equal
            XCTAssertGreaterThan( fruits.count, 20) // check greater than
            
            self.fruitsValues = fruits
            return Promise<FruitsListModel>.value(try JSONDecoder().decode(FruitsListModel.self, from: object!)) //this is fail case
        }.catch { [weak self] error in
            guard let self = self else { return }
            print("Error-->",error.localizedDescription)
            XCTFail(error.localizedDescription)
        }
            .finally {
                self.test_By_category(type: .AllFruits)
                sleep(2)
                self.test_By_category(type: .FruitsByFamily)
                sleep(2)
                self.test_By_category(type: .FruitsByGenus)
                sleep(2)
                self.test_By_category(type: .FruitsByOrder)
                sleep(2)
                print(self.filteredResponse1?.count)
                print(self.filteredResponse2?.count)
                print(self.filteredResponse3?.count)
                print(self.filteredResponse4?.count)

                expect.fulfill()
            }
        
        wait(for: [expect], timeout: 10.0) //Timeout
    }
    
    func test_fetch_all_fruits() {
        
        // Given A apiservice
        let sut = self.apiCall
        XCTAssertEqual(sut?.urlRequest?.url?.absoluteString ?? "", "https://www.fruityvice.com/api/fruit/all") //Check URL is correct
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        let todosPromise: Promise<FruitsListModel> = session.request(sut!)
        firstly {
            todosPromise
        }.then { [weak self] fruits -> Promise<FruitsListModel> in
            guard let self = self else { throw InternalError.unexpected }
            //XCTAssertEqual( fruits.count, 20)
            XCTAssertEqual( fruits.count, 42) //Check total counts are equal
            XCTAssertGreaterThan( fruits.count, 20) // check greater than
            
            self.fruitsValues = fruits
            //return Promise<FruitsListModel>.value(try JSONDecoder().decode(FruitsListModel.self, from: object!)) this is fail case
            return Promise<FruitsListModel>.value(fruits)
        }.catch { [weak self] error in
            guard let self = self else { return }
            print("Error-->",error.localizedDescription)
            XCTFail(error.localizedDescription)
        }
            .finally {
                self.test_By_category(type: .AllFruits)
                sleep(2)
                self.test_By_category(type: .FruitsByFamily)
                sleep(2)
                self.test_By_category(type: .FruitsByGenus)
                sleep(2)
                self.test_By_category(type: .FruitsByOrder)
                sleep(2)
                print(self.filteredResponse1?.count)
                print(self.filteredResponse2?.count)
                print(self.filteredResponse3?.count)
                print(self.filteredResponse4?.count)

                expect.fulfill()
            }
        
        wait(for: [expect], timeout: 10.0) //Timeout
    }
    
    func test_By_category(type:Category) {
        XCTAssertGreaterThan( self.fruitsValues?.count ?? 0, 0) // check greater than
        if let dataV = self.fruitsValues {
            
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
            
            switch type {
            case .AllFruits:
                self.filteredResponse1 = Array(valueData).sorted(by: {$0.key < $1.key})
            case .FruitsByFamily:
                self.filteredResponse2 = Array(valueData).sorted(by: {$0.key < $1.key})
            case .FruitsByGenus:
                self.filteredResponse3 = Array(valueData).sorted(by: {$0.key < $1.key})
            case .FruitsByOrder:
                self.filteredResponse4 = Array(valueData).sorted(by: {$0.key < $1.key})
            }
        }
        
    }
}

