//
//  WeatherArrayTests.swift
//  DataCrossingTests
//
//  Created by Natalie on 1/25/22.
//

import XCTest
@testable import DataCrossing

class WeatherArrayTests: XCTestCase {
    
    var weatherArrays: WeatherPatternArrays!
    
    override func setUp() {
        super.setUp()
        weatherArrays = WeatherPatternArrays()
    }

    override func tearDown() {
        super.tearDown()
        weatherArrays = nil
    }
    
    func testFindPatterns() {
        let pattern = weatherArrays.findPattern(weather: [0: "Clear", 1: "Clear", 2: "Sunny", 3: "Sunny", 4: "Clear"])
        XCTAssertEqual(pattern[0], "Fine00")
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
