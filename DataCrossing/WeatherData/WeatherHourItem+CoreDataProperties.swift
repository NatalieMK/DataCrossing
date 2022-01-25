//
//  WeatherHourItem+CoreDataProperties.swift
//  
//
//  Created by Natalie on 1/25/22.
//
//

import Foundation
import CoreData


extension WeatherHourItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherHourItem> {
        return NSFetchRequest<WeatherHourItem>(entityName: "WeatherHourItem")
    }

    @NSManaged public var hour: Int16
    @NSManaged public var pattern: String?
    @NSManaged public var dayWeather: WeatherItem?

}
