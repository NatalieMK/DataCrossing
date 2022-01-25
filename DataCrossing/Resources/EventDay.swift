//
//  EventDays.swift
//  DataCrossing
//
//  Created by Natalie on 12/21/21.
//

import Foundation

// extension to Date() containing all holidays and events in Animal Crossing: New Horizons (US)

// Algorithm found on Stack Overflow (answer by "David Thorsun")
// https://stackoverflow.com/questions/30836183/using-nsdate-to-get-date-for-easter/46961800#46961800



extension Date {

    var isACHoliday: Bool {

        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: self)
        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let weekday = components.weekday,
            let weekdayOrdinal = components.weekdayOrdinal else { return false }

        let easterDateComponents = Date.dateComponentsForEaster(year: year)
        let easterMonth: Int = easterDateComponents?.month ?? -1
        let easterDay: Int = easterDateComponents?.day ?? -1
        
        let festivaleDateComponents = Date.dateComponentsForFestivale(year: year)
        let festivaleMonth: Int = festivaleDateComponents?.month ?? -1
        let festivaleDay: Int = festivaleDateComponents?.day ?? -1

        // weekday is Sunday==1 ... Saturday==7
        // weekdayOrdinal is nth instance of weekday in month

        switch (month, day, weekday, weekdayOrdinal) {
        case (1, 1, _, _): return true                      // New Year's Day
        case (2, 14, _, _): return true                     // Valentine's Day
            
        // Festivale will occur one day before Mardi Gras, 48 days before Bunny Day
        case (festivaleMonth, festivaleDay, _, _): return true // Festivale
            
        // Bunny Day will have a one-week prep period, which is also part of the Bunny Day event
        case (easterMonth, easterDay, _, _): return true    // Bunny Day (Easter)
        
        case (4, 22, _, _): return true                     // Nature Day (Earth Day)
            
        case (10, 31, _, _): return true                    // Halloween
            
        case (11, 0, 5, 4): return true                     // Turkey Day/ Harvest Festival (Thanksgiving)
        
        // Festive Season will run from December 15th to January 6th
        case (12, 24, _, _): return true                    // Toy Day (Christmas Eve)
        case (12, 31, _, _): return true                    // New Year's Eve
            
        default: return false
        }

    }
    
    // Events in game - special days that aren't national or international holidays but are independent of hemisphere.
    
    var isACEvent: Bool{
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: self)
        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let weekday = components.weekday,
            let weekdayOrdinal = components.weekdayOrdinal else { return false }
        
        switch (month, day, weekday, weekdayOrdinal) {
        
            // Fishing Tourney dates are universal - second Saturday of the month, once per season
        case (1, 0, 7, 2): return true                      // Fishing Tourney
        case (4, 0, 7, 2): return true                      // Fishing Tourney
        case (7, 0, 7, 2): return true                      // Fishing Tourney
        case (11, 0, 7, 2): return true                     // Fishing Tourney
            
            // The May Day event will run from May 1st - May 7th
        case (5, _, _, 1): return true                      // May Day Event
            
            // International Museum Day will run from May 18th - May 31st
        case (5, 18, _, _): return true
        case (5, 19, _, _): return true
        case (5, 20, _, _): return true
        case (5, 21, _, _): return true
        case (5, 22, _, _): return true
        case (5, 23, _, _): return true
        case (5, 24, _, _): return true
        case (5, 25, _, _): return true
        case (5, 26, _, _): return true
        case (5, 27, _, _): return true
        case (5, 28, _, _): return true
        case (5, 29, _, _): return true
        case (5, 30, _, _): return true
        case (5, 31, _, _): return true
            
            // June is wedding season
        case (6, _, _, _): return true                      // Wedding Season
            
            // Every Sunday in August is the Fireworks Show
        case (8, _, 1, _): return true                      // Fireworks Show
            
        default: return false
        }
        
    }
    
    // Events and seasons that occur at different times in each hemisphere
    var isSouthernEvent: Bool {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: self)
        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let weekday = components.weekday,
            let weekdayOrdinal = components.weekdayOrdinal else { return false }
            
        switch (month, day, weekday, weekdayOrdinal) {
            // Bug Offs are seasonal, and will occur whenever "Summer" occurs in the island's hemisphere
        case (1, 0, 7, 3): return true                      // Bug Off - Southern
        case (2, 0, 7, 3): return true                      // Bug Off - Southern
        case (11, 0, 7, 3): return true                     // Bug Off - Southern
        case (12, 0, 7, 3): return true                     // Bug Off - Southern
            
            // Mushrooming Season runs throughout May in the Southern Hemisphere
        case (5, _, _, _): return true                      // Mushrooming Season
            
            // October 1st - 10th is Cherry Blossom Season in the Southern Hemisphere
        case (10, _, _, 1): return true                        // Cherry Blossom Season (10/1 - 10/7)
        case (10, 8, _, _): return true
        case (10, 9, _, _): return true
        case (10, 10, _, _): return true
            
        default: return false
        }}
    
    var isNorthernEvent: Bool {
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: self)
        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let weekday = components.weekday,
            let weekdayOrdinal = components.weekdayOrdinal else { return false }
        
        switch (month, day, weekday, weekdayOrdinal) {
            // April 1st - 10th is Cherry Blossom Season in the Northern Hemisphere
        case (4, 0, 0, 1): return true                         // Cherry Blossom Season (4/1 - 4/7)
        case (4, 8, 0, 0): return true
        case (4, 9, 0, 0): return true
        case (4, 10, 0, 0): return true
            // Bug Offs are seasonal, and will occur whenever "Summer" occurs in the island's hemisphere
        case (6, 0, 7, 4): return true                      // Bug Off - Northern
        case (7, 0, 7, 4): return true                      // Bug Off - Northern
        case (8, 0, 7, 4): return true                      // Bug Off - Northern
        case (9, 0, 7, 4): return true                      // Bug Off - Northern
            // Mushrooming Season runs through November in the Northern Hemisphere
        case (11, _, _, _): return true                     // Mushrooming Season
        default: return false
        }}
    
    // International Events without in-game event celebrations, but appear in Nook Shopping
//    var isInternationalEvent: Bool {
//
//    }
//
    
    // MARK: Static Functions
    
    static func dateComponentsForFestivale(year: Int) -> DateComponents? {
        
        // Easter calculation from Anonymous Gregorian algorithm
        // AKA Meeus/Jones/Butcher algorithm
        let a = year % 19
        let b = Int(floor(Double(year) / 100))
        let c = year % 100
        let d = Int(floor(Double(b) / 4))
        let e = b % 4
        let f = Int(floor(Double(b+8) / 25))
        let g = Int(floor(Double(b-f+1) / 3))
        let h = (19*a + b - d - g + 15) % 30
        let i = Int(floor(Double(c) / 4))
        let k = c % 4
        let L = (32 + 2*e + 2*i - h - k) % 7
        let m = Int(floor(Double(a + 11*h + 22*L) / 451))
        var dateComponents = DateComponents()
        
        dateComponents.month = Int(floor(Double(h + L - 7*m + 114) / 31))
        dateComponents.day = ((h + L - 7*m + 114) % 31) + 1
        dateComponents.year = year
        
        guard let easter = Calendar.current.date(from: dateComponents) else { return nil } // Convert to calculate weekday, weekdayOrdinal
        
        guard let festivale = Calendar.current.date(byAdding: .day, value: -48, to: easter, wrappingComponents: false) else { return nil}
        
        dateComponents.month = Calendar.current.component(.month, from: festivale)
        dateComponents.day = Calendar.current.component(.day, from: festivale)

        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: festivale)
    }


    static func easterHoliday(year: Int) -> Date? {
        guard let dateComponents = Date.dateComponentsForEaster(year: year) else { return nil }
        return Calendar.current.date(from: dateComponents)
    }

    static func dateComponentsForEaster(year: Int) -> DateComponents? {
        // Easter calculation from Anonymous Gregorian algorithm
        // AKA Meeus/Jones/Butcher algorithm
        let a = year % 19
        let b = Int(floor(Double(year) / 100))
        let c = year % 100
        let d = Int(floor(Double(b) / 4))
        let e = b % 4
        let f = Int(floor(Double(b+8) / 25))
        let g = Int(floor(Double(b-f+1) / 3))
        let h = (19*a + b - d - g + 15) % 30
        let i = Int(floor(Double(c) / 4))
        let k = c % 4
        let L = (32 + 2*e + 2*i - h - k) % 7
        let m = Int(floor(Double(a + 11*h + 22*L) / 451))
        var dateComponents = DateComponents()
        dateComponents.month = Int(floor(Double(h + L - 7*m + 114) / 31))
        dateComponents.day = ((h + L - 7*m + 114) % 31) + 1
        dateComponents.year = year
        guard let easter = Calendar.current.date(from: dateComponents) else { return nil } // Convert to calculate weekday, weekdayOrdinal
        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekdayOrdinal], from: easter)
    }
    
    // MARK: - Public functions

public func nextFishingTourney() -> Date{
    let tourneys = [Calendar.current.nextDate(after: self, matching: DateComponents(month: 1, weekday:                      7, weekdayOrdinal: 2), matchingPolicy: Calendar.MatchingPolicy.nextTime),
                    Calendar.current.nextDate(after: self, matching: DateComponents(month: 4, weekday: 7, weekdayOrdinal: 2), matchingPolicy: Calendar.MatchingPolicy.nextTime),
                    Calendar.current.nextDate(after: self, matching: DateComponents(month: 7, weekday: 7, weekdayOrdinal: 2), matchingPolicy: Calendar.MatchingPolicy.nextTime),
                    Calendar.current.nextDate(after: self, matching: DateComponents(month: 11, weekday: 7, weekdayOrdinal: 2), matchingPolicy: Calendar.MatchingPolicy.nextTime)]
    
    var closestTourneyDistance = Double(366 * 60 * 60 * 60) // Farthest date possible in seconds
    var closestTourney = Date()
    for tourney in tourneys {
        let distance = self.distance(to: tourney!)
        if distance < closestTourneyDistance {
            closestTourney = tourney!
            closestTourneyDistance = distance
        }
    }
    return closestTourney
}
    
    public func nextBugOff(hemisphere: Int) -> Date{
        var bugOffs = [Date?]()
        switch hemisphere {
            // Northern
        case 0:
            bugOffs = [Calendar.current.nextDate(after: self, matching: DateComponents(month: 6, weekday: 7, weekdayOrdinal: 4), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 7, weekday:                      7, weekdayOrdinal: 4), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 8, weekday:                      7, weekdayOrdinal: 4), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 9, weekday:                      7, weekdayOrdinal: 4), matchingPolicy: Calendar.MatchingPolicy.nextTime)]
            // Southern
        default:
            bugOffs = [Calendar.current.nextDate(after: self, matching: DateComponents(month: 1, weekday: 7, weekdayOrdinal: 3), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 2, weekday:                      7, weekdayOrdinal: 3), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 11, weekday:                      7, weekdayOrdinal: 3), matchingPolicy: Calendar.MatchingPolicy.nextTime), Calendar.current.nextDate(after: self, matching: DateComponents(month: 12, weekday:                      7, weekdayOrdinal: 3), matchingPolicy: Calendar.MatchingPolicy.nextTime)]
        }
        
        var closestBugOffDistance = Double(366 * 60 * 60 * 60)
        var closestBugOff = Date()
        
        for bugOff in bugOffs {
            let distance = self.distance(to: bugOff!)
            if distance < closestBugOffDistance {
                closestBugOff = bugOff!
                closestBugOffDistance = distance
            }
        }
        return closestBugOff
    }

}

