//
//  MeteoNookController.swift
//  DataCrossing
//
//  Created by Natalie on 12/20/21.
//

import Foundation

enum MeteoNookControllerError: Error{
    case failureBeforeInput
}
public class MeteoNookController {
    
    var islandControl = IslandDataController()
    var islandDate = Date()
    
    public func weatherForWeek() -> [String]{
        islandDate = islandControl.getIslandDate()!
        var weekWeather = [String]()
        for num in 0 ..< 8{
            let prediction = getMeteoNookPrediction(date: Calendar.current.date(byAdding: .day, value: num, to: islandDate)!)
            weekWeather.append(prediction)
        }
        return weekWeather
        }
    
//    public func weatherForDay() -> [String]{
//        islandDate = islandControl.getIslandDate()!
//        
//    
//        let prediction = getMeteoNookPrediction(date: Date())
//        
//    }
    
    public func weatherForHours() -> [String]{
        islandDate = islandControl.getIslandDate()!
        var hourWeather = [String]()
        for num in 0 ..< 24 {
            let prediction = getMeteoNookPredictions(date: islandDate, hour: num)
            hourWeather.append(prediction)
        }
        return hourWeather
    }
    
    public func getMeteoNookPredictions(date: Date, hour: Int) -> String{
        var dict : [String: Int] = ["year": 0, "month": 0, "day": 0, "hour": hour,"seed": 0]
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        dict["year"] = components.year
        dict["day"] = components.day
        dict["month"] = components.month
        var weather: String?
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            guard let inputString = String(data: jsonData, encoding: .utf8) else { throw MeteoNookControllerError.failureBeforeInput}
            let input = MeteoNookCaller.call.parse_hour(to: inputString)
            weather = MeteoNookCaller.call.getDayWeather(with: input)
        } catch {
            
        }
        return weather!
    }
    
    func getMeteoNookPrediction(date: Date) -> String{
        var dict : [String: Int] = ["year": 0, "day": 0, "month": 0, "seed": 0]
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        dict["year"] = components.year
        dict["day"] = components.day
        dict["month"] = components.month
        var weather: String?
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            guard let inputString = String(data: jsonData, encoding: .utf8) else { throw MeteoNookControllerError.failureBeforeInput}
            let input = MeteoNookCaller.call.parse(to: inputString)
            weather = MeteoNookCaller.call.getDayWeather(with: input)
        } catch {
            
        }
        return weather!
    }
    
}
