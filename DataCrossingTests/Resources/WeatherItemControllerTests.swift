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
        XCTAssertTrue(!array.isEmpty)
        XCTAssertTrue(array.contains(firstHour))
    }
    
    func test_getWeatherItems(){
        let dateComponents = DateComponents(year: 2000, month: 2, day: 2)
        guard let date = Calendar.current.date(from: dateComponents) else { return }

        do {
            try weatherItemController.newWeatherItem(weatherDate: Date())
            try weatherItemController.newWeatherItem(weatherDate: date)
            try weatherItemController.saveWeatherForHour(hour: 3, pattern: "Sunny", date: date)
            let dates = try dataStack.mainContext.fetch(WeatherItem.fetchRequest())
            XCTAssert(dates.isEmpty != true)
        }
        catch {
        }
        do { let items = try weatherItemController.getWeatherItems()
            XCTAssertTrue(items.count == 2)
        } catch {
        }
        
    }
    
    func test_newWeatherItem(){
        do { try weatherItemController.newWeatherItem(weatherDate: Date())
            let dates = try dataStack.mainContext.fetch(WeatherItem.fetchRequest())
            XCTAssert(dates.isEmpty != true)
        }
        catch {
        }
    }
    
    func test_getWeatherItemAtDate_isDate(){
        let dateComponents = DateComponents(year: 2000, month: 2, day: 2)
        guard let date = Calendar.current.date(from: dateComponents) else { return }
        do {
            try weatherItemController.newWeatherItem(weatherDate: date)
        } catch { return }
        do {
            let savedDate = try weatherItemController.getWeatherItemAtDate(weatherDate: date)
            XCTAssertTrue(savedDate != nil)
        } catch { return }
    }
    
    func test_checkForMatchingHour_isMatchingHour(){
        let dateComponents = DateComponents(year: 2000, month: 2, day: 2)
        guard let date = Calendar.current.date(from: dateComponents) else { return }
        do {
            try weatherItemController.newWeatherItem(weatherDate: date)
            try weatherItemController.makeWeatherForHour(hour: 2, pattern: "Sunny", date: date)
        } catch { return }
        XCTAssertTrue(weatherItemController.checkForMatchingHour(hour: 2, date: date))
    }
    
}
