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
    
    // Tests for findPatterns
    
    
    func testFindPatterns() {
        let pattern = weatherArrays.findPattern(weather: [0: "Clear", 1: "Clear", 2: "Sunny", 3: "Sunny", 4: "Clear"])
        XCTAssertEqual(pattern[0], "Fine00")
    }
    
    func test_findPatterns_multiplePatternsPossible() {
        let pattern = weatherArrays.findPattern(weather: [0: "Clear"])
        XCTAssertTrue(pattern.count > 1)
        XCTAssertTrue(pattern.contains("Fine00"))
        XCTAssertTrue(pattern.contains("Fine01"))
        XCTAssertTrue(pattern.contains("Fine02"))
        XCTAssertTrue(pattern.contains("Fine06"))
        XCTAssertTrue(pattern.contains("EventDay00"))
 
    }
    
    func testGetPatternsFromString(){
        let patternString = ["Fine00"]
        let pattern = weatherArrays.getPatternsFrom(patternString: patternString)
        XCTAssertTrue(pattern.count != 0)
        XCTAssertEqual(pattern, [ "Fine00" : ["Clear", "Clear", "Sunny", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Clear", "Clear", "Sunny", "Clear"]])
    }
    
    func testGetStringFromPatterns(){
        let patterns = [ "Fine00" : ["Clear", "Clear", "Sunny", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Clear", "Clear", "Sunny", "Clear"]]
        let patternString = weatherArrays.getStringArrayFrom(patternDictionary: patterns)
        XCTAssertEqual(patternString, ["Fine00"])
        
    }
    
    func testIsPossible(){
        let weatherItems = [0: "Clear", 1: "Clear"]
        let returnString = weatherArrays.getPossiblePatterns(weatherItemPairs: weatherItems)
        XCTAssertTrue(!returnString.isEmpty)
        XCTAssertTrue(returnString.contains("Fine00"))
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
