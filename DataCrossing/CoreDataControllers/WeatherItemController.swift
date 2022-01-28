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
    case invalidDate
}

enum WeatherHourItemControllerError: Error {
    case savingError
    case weatherNotPossible
    case hourAlreadyExists
    case noDaySaved
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
        guard let day = date.day else { return }
        guard let month = date.month else { return }
        guard let year = date.year else { return }
        let newWeatherItem = WeatherItem(context: mainContext)
        newWeatherItem.day = Int16(day)
        newWeatherItem.month = Int16(month)
        newWeatherItem.year = Int16(year)
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
            let itemList = try mainContext.fetch(WeatherItem.fetchRequest())
            for item in itemList {
            if (item is WeatherHourItem) {
            } else {
                items.append(item)
            }
            }
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
                    print("Found")
                    return
                }
            }
            try newWeatherItem(weatherDate: date!)
            print("Created")
            
        } catch WeatherItemControllerError.errorSaving{
            print("Error saving")
        } catch {
            print("Some other Error")
        }
    }
    
    // input => Date
    // output => WeatherItem if there is currently a weatherItem at that date
            //=> nil if no WeatherItem matches that date
    // throws Error if a CoreData error occurs
    public func getWeatherItemAtDate(weatherDate: Date) throws -> WeatherItem? {
        do {
            let date = Calendar.current.dateComponents([.day, .month, .year], from: weatherDate)
            guard let day = date.day else { throw WeatherItemControllerError.invalidDate}
            guard let month = date.month else { throw WeatherItemControllerError.invalidDate }
            guard let year = date.year else { throw WeatherItemControllerError.invalidDate }
            
            let savedDates = try mainContext.fetch(WeatherItem.fetchRequest())
            for savedDate in savedDates {
                if savedDate.day == day {
                    if savedDate.month == month {
                        if savedDate.year == year{
                            return savedDate
                        }}}}
        } catch {
            throw WeatherItemControllerError.couldNotRetrieve
        }
        return nil
    }
    
    // Gets array of WeatherHourItems from NSOrderedSet hours in WeatherItem
    func getHourItems(weatherItem: WeatherItem) -> [WeatherHourItem?]{
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
        for hour in hours {
            let pair = asKeyValuePair(weatherItem: hour!)
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
    
    func checkForMatchingHour(hour: Int16, date: Date) -> Bool{
        do {
            let weatherItem = try getWeatherItemAtDate(weatherDate: date)
            let hours = getHourItems(weatherItem: weatherItem!)
            for hourItem in hours {
                if hourItem?.hour == hour {
                    return true
                }
            }
        } catch {
            return false
        }
        return false
    }
    
    func makeWeatherForHour(hour: Int16, pattern: String, date: Date) throws {
        let hourItem = WeatherHourItem(context: mainContext)
        hourItem.hour = hour
        hourItem.pattern = pattern
        hourItem.dayWeather = try getWeatherItemAtDate(weatherDate: date)
        if hourItem.dayWeather == nil {
            throw WeatherHourItemControllerError.noDaySaved
        }
        do {
            try mainContext.save()
            hourItem.dayWeather?.addToHours(hourItem)
        } catch {
            throw WeatherHourItemControllerError.savingError
        }
    }
    
    func saveWeatherForHour(hour: Int16, pattern: String, date: Date) throws{
        guard let dayWeather = try getWeatherItemAtDate(weatherDate: date)
        else { throw WeatherHourItemControllerError.noDaySaved }
        
        if checkForMatchingHour(hour: hour, date: date){
            throw WeatherHourItemControllerError.hourAlreadyExists
        }
        do {
            try makeWeatherForHour(hour: hour, pattern: pattern, date: date)
        } catch WeatherHourItemControllerError.noDaySaved{
            throw WeatherHourItemControllerError.noDaySaved
        }
        
        catch {
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
