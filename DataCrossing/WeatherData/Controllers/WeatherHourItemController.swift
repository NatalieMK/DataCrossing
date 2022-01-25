//
//  WeatherHourItemController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

// Controller for weather hour items, accessible by User

import Foundation
import CoreData

enum WeatherHourItemControllerError: Error {
    case savingError
}

public class WeatherHourItemController {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    func saveWeatherForHour(hour: Int16, pattern: String) throws{
        let hourItem = WeatherHourItem(context: mainContext)
        hourItem.hour = hour
        hourItem.pattern = pattern
        do {
            try mainContext.save()
        } catch {
            throw WeatherHourItemControllerError.savingError
        }
    }
    

}
