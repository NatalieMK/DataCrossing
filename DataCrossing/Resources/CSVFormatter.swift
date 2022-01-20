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
            return "N/A"
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
}
