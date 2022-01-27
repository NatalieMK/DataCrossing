//
//  WeatherItemControllerTests.swift
//  DataCrossingTests
//
//  Created by Natalie on 1/25/22.
//

import XCTest
@testable import DataCrossing

class WeatherItemControllerTests: XCTestCase {

    var weatherItem: WeatherItem!
    var weatherItemController: WeatherItemController!
    var dataStack: CoreDataTestStack!
   
    
    override func setUp() {
        super.setUp()
        dataStack = CoreDataTestStack()

        weatherItem = WeatherItem(context: dataStack.persistentContainer.viewContext)
                
        weatherItemController = WeatherItemController(mainContext: dataStack.mainContext)
    }

    override func tearDown() {
        super.tearDown()
        weatherItem = nil
        weatherItemController = nil
        dataStack = nil
    }
    
    func test_getHourItems() {
        let firstHour = WeatherHourItem(context: dataStack.persistentContainer.viewContext)
        firstHour.pattern = "Sunny"
        firstHour.hour = 1
        weatherItem.hours = NSOrderedSet.init(array: [firstHour])
        
        let array = weatherItemController.getHourItems(weatherItem: weatherItem)
        XCTAssertTrue(!array!.isEmpty)
        XCTAssertTrue(array!.contains(firstHour))
    }
    

}
