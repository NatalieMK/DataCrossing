//
//  WeatherItem+CoreDataProperties.swift
//  
//
//  Created by Natalie on 1/26/22.
//
//

import Foundation
import CoreData


extension WeatherItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherItem> {
        return NSFetchRequest<WeatherItem>(entityName: "WeatherItem")
    }

    @NSManaged public var day: Int16
    @NSManaged public var dayType: Int16
    @NSManaged public var doubleRainbow: Bool
    @NSManaged public var month: Int16
    @NSManaged public var rainbowTime: Int16
    @NSManaged public var year: Int16
    @NSManaged public var aurora: Bool
    @NSManaged public var meteor: Bool
    @NSManaged public var hours: NSOrderedSet?

}

// MARK: Generated accessors for hours
extension WeatherItem {

    @objc(insertObject:inHoursAtIndex:)
    @NSManaged public func insertIntoHours(_ value: WeatherHourItem, at idx: Int)

    @objc(removeObjectFromHoursAtIndex:)
    @NSManaged public func removeFromHours(at idx: Int)

    @objc(insertHours:atIndexes:)
    @NSManaged public func insertIntoHours(_ values: [WeatherHourItem], at indexes: NSIndexSet)

    @objc(removeHoursAtIndexes:)
    @NSManaged public func removeFromHours(at indexes: NSIndexSet)

    @objc(replaceObjectInHoursAtIndex:withObject:)
    @NSManaged public func replaceHours(at idx: Int, with value: WeatherHourItem)

    @objc(replaceHoursAtIndexes:withHours:)
    @NSManaged public func replaceHours(at indexes: NSIndexSet, with values: [WeatherHourItem])

    @objc(addHoursObject:)
    @NSManaged public func addToHours(_ value: WeatherHourItem)

    @objc(removeHoursObject:)
    @NSManaged public func removeFromHours(_ value: WeatherHourItem)

    @objc(addHours:)
    @NSManaged public func addToHours(_ values: NSOrderedSet)

    @objc(removeHours:)
    @NSManaged public func removeFromHours(_ values: NSOrderedSet)

}
