//
//  IslandDataControllerTests.swift
//  DataCrossingTests
//
//  Created by Natalie on 12/10/21.
//

import XCTest
@testable import DataCrossing

class IslandDataControllerTests: XCTestCase {

    var dataController: IslandDataController!
    var dataStack: CoreDataTestStack!
    var foundError: Error!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dataStack = CoreDataTestStack()
        dataController = IslandDataController(mainContext: dataStack.mainContext)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dataStack = nil
        dataController = nil
    }

    func testInitIsland() {
        do {
            try dataController.initIsland(name: "Orange Island", hemisphere: 1, islandDate: nil, weatherSeed: nil)
            let island = try dataController.getSavedIsland()
            XCTAssertEqual("Orange Island", island.islandName)
        }
        catch {
            foundError = error
        }
    }
    
    func testInitIslandGivenInvalidName() {
        XCTAssertThrowsError(try dataController.initIsland(name: "anamewithmorethantenletters", hemisphere: 1, islandDate: nil, weatherSeed: nil))
    }
    
    func testInitIslandGivenValidDate(){
        do{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy/MM/dd HH:mm"
            let date = dateFormat.date(from: "2016/10/08 22:31")
            try dataController.initIsland(name: "valid", hemisphere: 1, islandDate: date, weatherSeed: nil)
            let island = try dataController.getSavedIsland()
            XCTAssertEqual(date, island.currentIslandDate)
        } catch {
            foundError = error
        }
    }
    
    func testInitIslandGivenValidSeed() {
        do{
            try dataController.initIsland(name: "valid", hemisphere: 1, islandDate: nil, weatherSeed: 200)
            let island = try dataController.getSavedIsland()
            XCTAssertEqual(200, island.seed)
        } catch {
            foundError = error
        }
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
