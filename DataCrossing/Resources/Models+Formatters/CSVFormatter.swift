//
//  CSVFormatter.swift
//  DataCrossing
//
//  Created by Natalie on 1/11/22.
//

import Foundation

// Class to reformat CSV data into something more readable.

public class CSVFormatter {
    

    enum TimesAvailable: String, CaseIterable {
        case unavailable = "N/A"
        case allDay = "All Day"
        case time
    }
    
    enum WeatherAvailable: String, CaseIterable {
        case rain = "Yes"
        case noRain = "No"
    }
    
    private func determineTime(timeString: String) -> TimesAvailable{
        switch(timeString){
        case "0":
            return TimesAvailable.allDay
        case "nil", "NA":
            return TimesAvailable.unavailable
        default:
            return TimesAvailable.time
        }
    }
    
    public func formatTime(timeString: String) -> String{
        switch (determineTime(timeString: timeString)){
        case .allDay:
            return "All Day"
        case .unavailable:
            return "Unavailable"
        case .time:
            let filters = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
            let components = timeString.components(separatedBy: filters)
            var returnedTime = [String]()
            for component in components {
                let initialFormat = DateFormatter()
                initialFormat.dateFormat = "HHmm"
                let time = initialFormat.date(from: component)
                let newFormat = DateFormatter()
                newFormat.dateFormat = "h a"
                let timeString = newFormat.string(from: time!)
                returnedTime.append(timeString)
            }
            
            return ("\(returnedTime[0]) - \(returnedTime[1])")
        }
    }
    
    private func determineRain(rainString: String) -> WeatherAvailable{
        switch(rainString){
        case "no_rain":
            return WeatherAvailable.noRain
        default:
            return WeatherAvailable.rain
        }
    }
    
    public func formatRainString(rainString: String) -> String{
        switch(determineRain(rainString: rainString)){
        case .rain:
            return determineRain(rainString: rainString).rawValue
        default:
            return determineRain(rainString: rainString).rawValue
        }
    }
}
