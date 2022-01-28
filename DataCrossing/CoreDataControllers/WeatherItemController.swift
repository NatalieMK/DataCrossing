//
//  WeatherItemController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import Foundation
import CoreData

enum WeatherItemControllerError: Error {
    case weatherConflict
    case errorSaving
    case couldNotRetrieve
}

enum WeatherHourItemControllerError: Error {
    case savingError
    case weatherNotPossible
}

internal class WeatherItemController {
    
    let mainContext: NSManagedObjectContext
    var weatherData = WeatherPatternArrays()
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    // Create new WeatherItem, containing the data for an entire days worth of weather
    public func newWeatherItem(weatherDate: Date) throws{
        let date = Calendar.current.dateComponents([.day, .month, .year], from: weatherDate)
        let newWeatherItem = WeatherItem(context: mainContext)
        newWeatherItem.day = Int16(date.day!)
        newWeatherItem.month = Int16(date.month!)
        newWeatherItem.year = Int16(date.year!)
        do {
            try mainContext.save()
        } catch {
            throw WeatherItemControllerError.errorSaving
        }
    }
    // get all saved WeatherItems
    public func getWeatherItems() throws -> [WeatherItem] {
        var items = [WeatherItem]()
        do {
            items = try mainContext.fetch(WeatherItem.fetchRequest())
        } catch {}
        return items
    }
    
    // checks for previously saved item on this date. Creates new WeatherItem if date does not currently have one
    public func isWeatherItem(weatherDate: Date) {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: weatherDate)
        let date = Calendar.current.date(from: dateComponents)
        do {
            let savedDates = try mainContext.fetch(WeatherItem.fetchRequest())
            for savedDate in savedDates {
                let components = DateComponents(year: Int(savedDate.year), month: Int(savedDate.month), day: Int(savedDate.day))
                let savedDate = Calendar.current.date(from: components)
                if date == savedDate {
                    return
                }
            }
            try newWeatherItem(weatherDate: date!)
            
        } catch WeatherItemControllerError.errorSaving{
            
        } catch {
            
        }
    }
    
    // input => Date
    // output => WeatherItem if there is currently a weatherItem at that date
            //=> nil if no WeatherItem matches that date
    // throws Error if a CoreData error occurs
    public func getWeatherItemAtDate(weatherDate: Date) throws -> WeatherItem? {
        do {
            let date = Calendar.current.dateComponents([.day, .month, .year], from: weatherDate)
            let savedDates = try mainContext.fetch(WeatherItem.fetchRequest())
            for savedDate in savedDates {
                if savedDate.day == date.day! {
                    if savedDate.month == date.month! {
                        if savedDate.year == date.year!{
                            return savedDate
                        }}}}
            
        } catch {
            throw WeatherItemControllerError.couldNotRetrieve
        }
        return nil
    }
    
    
    
    // Gets array of WeatherHourItems from NSOrderedSet hours in WeatherItem
    func getHourItems(weatherItem: WeatherItem) -> [WeatherHourItem]?{
        var savedHourItems = [WeatherHourItem]()
        let hours = weatherItem.hours?.array
        if (hours != nil){
            for hour in hours! {
                let hourItem = hour as? WeatherHourItem
                if (hourItem != nil) {
                    savedHourItems.append(hourItem!)
                }
            }
        }
        return savedHourItems
    }
    
    // Check that weather entered is possible (i.e. there are still possible patterns containing this and any saved WeatherHourItems)
    
    func isWeatherPossibleForDay(newHourItem: WeatherHourItem, weatherItem: WeatherItem) -> Bool{

        var hours = getHourItems(weatherItem: weatherItem)
        var pairs: [Int:String] = [:]
        for hour in hours! {
            let pair = asKeyValuePair(weatherItem: hour)
            pairs.updateValue((pair.first?.value)!, forKey: (pair.first?.key)!)
        }
        let patternString = weatherData.getPossiblePatterns(weatherItemPairs: pairs)
        var possiblePatterns = weatherData.getPatternsFrom(patternString: patternString)
        if (weatherData.getPossiblePatterns(weatherItemPairs: asKeyValuePair(weatherItem: newHourItem))).count > 0 {
            return true
        }
        return false
    }
}

// WeatherHourItem Functions
extension WeatherItemController {
    
    func saveWeatherForHour(hour: Int16, pattern: String, date: Date) throws{
        let hourItem = WeatherHourItem(context: mainContext)
        hourItem.hour = hour
        hourItem.pattern = pattern
        if !isWeatherPossibleForHour(hourItem: hourItem) {
            throw WeatherHourItemControllerError.weatherNotPossible
        }
        isWeatherItem(weatherDate: date)
        do {
            try mainContext.save()
        } catch {
            throw WeatherHourItemControllerError.savingError
        }
    }
    
    func asKeyValuePair(weatherItem: WeatherHourItem) -> [Int: String]{
        let key = weatherItem.hour
        let value = weatherItem.pattern
        return [Int(key): value!]
    }
    
    func isWeatherPossibleForHour(hourItem: WeatherHourItem) -> Bool {
        return true
    }
}
