//
//  CreateDataControllerTests.swift
//  DataCrossingTests
//
//  Created by Natalie on 1/9/22.
//

import XCTest
@testable import DataCrossing

class CreateDataControllerTests: XCTestCase {
    
    var foundError: Error!
    var dataController: IslandDataController!
    var dataStack: CoreDataTestStack!
    var createController: CreateIslandController!

    override func setUp() {
        super.setUp()
        createController = CreateIslandController()
        dataStack = CoreDataTestStack()
        dataController = IslandDataController(mainContext: dataStack.mainContext)
    }

    override func tearDown() {
        super.tearDown()
        createController = nil
        dataStack = nil
        dataController = nil
    }
    
    func testCreateIsland() {
        do {
            try createController.createIsland(islandName: "Apple Island", hemi: 0, doesTimeTravel: false, islandDate: Date(), seed: nil)
            let island = try dataController.getSavedIsland()
            XCTAssertEqual("Apple Island", island.islandName)
        } catch {
        }
    }
    
    func testNameTooShort(){
        XCTAssertThrowsError(try createController.createIsland(islandName: "", hemi: 0, doesTimeTravel: false, islandDate: Date(), seed: nil), "Name is too Short") { error in
            XCTAssertEqual(error as! CreateIslandControllerError, CreateIslandControllerError.nameTooShort)
        }
    }
    
    func testNameTooLong(){
        XCTAssertThrowsError(try createController.createIsland(islandName: "SuperLongIslandName", hemi: 0, doesTimeTravel: false, islandDate: Date(), seed: nil), "Name is too Long") { error in
            XCTAssertEqual(error as! CreateIslandControllerError, CreateIslandControllerError.nameTooLong)
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
