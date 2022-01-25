//
//  WeatherPatternArrays.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import Foundation

public class WeatherPatternArrays {
    
    var patterns = [
        
        "Fine00" : ["Clear", "Clear", "Sunny", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Clear", "Clear", "Sunny", "Clear"],  // Fine00
        
        "Fine01" : ["Clear", "Clear", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "Sunny", "Cloudy", "Sunny", "Clear", "Sunny"],  // Fine01
        
        "Fine02:" : ["Clear", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Cloudy", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Sunny", "Sunny", "Sunny", "Clear", "Clear"],  // Fine02
        
        "Fine03:" : ["Clear", "Sunny", "Clear", "Clear", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Clear", "Cloudy", "Clear", "Clear", "Sunny"],  // Fine03
        
        "Fine04:" : ["Clear", "Clear", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear"],  // Fine04
        
        "Fine05:" : ["Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny"],  // Fine05
        
        "Fine06:" : ["Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Cloudy", "Sunny", "Sunny", "Cloudy", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Cloudy", "Sunny", "Sunny", "Sunny", "Clear", "Clear"],  // Fine06
        
        "Cloud00" : ["Sunny", "Sunny", "Sunny", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Sunny"],  // Cloud00
        
        "Cloud01" : ["Sunny", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Sunny", "Cloudy", "Cloudy", "Cloudy", "RainClouds","RainClouds","Cloudy", "Cloudy", "Sunny", "Sunny", "Sunny"],  // Cloud01
        
    "Cloud02" : ["Cloudy", "Cloudy", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Cloudy", "RainClouds","Cloudy", "Cloudy"],  // Cloud02
    
        "Rain00" : ["Sunny", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Rain", "RainClouds","Cloudy", "Sunny", "RainClouds","Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Cloudy"],  // Rain00
        
        "Rain01" : ["RainClouds","Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "RainClouds","Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","HeavyRain","Rain", "Rain", "Rain", "Rain", "Sunny", "Sunny", "Cloudy"],  // Rain01
        
    "Rain02" : ["RainClouds","Cloudy", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "RainClouds","Rain", "Sunny", "RainClouds","Rain", "Rain", "Rain", "Cloudy", "Rain", "Rain", "Rain", "RainClouds","HeavyRain","Rain", "Rain", "Rain"],  // Rain02
        
    "Rain03" : ["Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "RainClouds","Rain", "Rain", "HeavyRain","HeavyRain","Rain", "Rain", "HeavyRain","HeavyRain","HeavyRain","HeavyRain","Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "RainClouds"], // Rain03
        
    "Rain04" : ["Rain", "Rain", "HeavyRain","HeavyRain","Rain", "Rain", "Rain", "HeavyRain","HeavyRain","HeavyRain","HeavyRain","Rain", "HeavyRain","HeavyRain","HeavyRain","Rain", "Rain", "HeavyRain","HeavyRain","HeavyRain","HeavyRain","HeavyRain","HeavyRain","Rain"],  // Rain04
        
    "Rain05" : ["RainClouds","Rain", "Rain", "HeavyRain","Rain", "HeavyRain","HeavyRain","Rain", "Rain", "HeavyRain","HeavyRain","HeavyRain","HeavyRain","Rain", "HeavyRain","HeavyRain","HeavyRain","HeavyRain","HeavyRain","HeavyRain","Rain", "Rain", "Cloudy", "Sunny"],  // Rain05
        
        "FineCloud00" : ["RainClouds","Cloudy", "RainClouds","RainClouds","Cloudy", "Rain", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Cloudy", "Cloudy", "Cloudy", "Cloudy"],  // FineCloud00
        
        "FineCloud01" : ["Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "RainClouds","Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Cloudy", "Cloudy"],  // FineCloud01
        
    "FineCloud02" : ["Rain", "Rain", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "Cloudy", "Sunny", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Cloudy", "RainClouds","RainClouds","Rain"],  // FineCloud02
        
        "CloudFine00" : ["Clear", "Sunny", "Sunny", "Sunny", "Sunny", "RainClouds","Rain", "Rain", "Cloudy", "Rain", "Sunny", "Cloudy", "Sunny", "Cloudy", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Clear"],  // CloudFine00
        
        "CloudFine01" : ["Sunny", "Clear", "Clear", "Sunny", "Sunny", "Sunny", "Rain", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Rain", "Sunny", "Sunny", "Cloudy", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny"],  // CloudFine01
        
    "CloudFine02" : ["Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Cloudy", "RainClouds","Rain", "Cloudy", "RainClouds","Rain", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Clear", "Sunny", "Clear"],  // CloudFine02
        
        "FineRain00" : ["Clear", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Rain", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny"],  // FineRain00
        
        "FineRain01" : ["Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Rain", "Cloudy", "Rain", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Sunny"],  // FineRain01
        
    "FineRain02" : ["Sunny", "Clear", "Clear", "Sunny", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "HeavyRain","Cloudy", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear"],  // FineRain02
        
    "FineRain03" : ["Clear", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Clear", "Sunny", "Sunny", "HeavyRain","Rain", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny"],  // FineRain03
        
        "CloudRain00" : ["Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "Cloudy", "Sunny", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "HeavyRain","HeavyRain","Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain"],  // CloudRain00
        
        "CloudRain01" : ["Rain", "Rain", "Rain", "Rain", "Cloudy", "Cloudy", "Sunny", "Sunny", "Cloudy", "Cloudy", "Rain", "Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "Rain", "Rain"],  // CloudRain01
        
    "CloudRain02" : ["HeavyRain","HeavyRain","Rain", "HeavyRain","Rain", "Rain", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "RainClouds"], // CloudRain02
        
        "RainCloud00" : ["Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "Cloudy", "Rain", "Rain", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Cloudy", "RainClouds","Cloudy", "Sunny", "Sunny", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy"],  // RainCloud00
        
        "RainCloud01" : ["Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Rain", "Cloudy", "RainClouds","Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Sunny", "Sunny"],  // RainCloud01
        
    "RainCloud02" : ["Sunny", "Sunny", "Cloudy", "Cloudy", "RainClouds","RainClouds","HeavyRain","HeavyRain","Rain", "Rain", "Rain", "Cloudy", "Cloudy", "Rain", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "Cloudy", "RainClouds","Cloudy", "RainClouds","Cloudy", "Cloudy"],  // RainCloud02
        
        "Commun00" : ["Clear", "Clear", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Cloudy", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Cloudy", "Sunny", "Cloudy", "Sunny", "Clear", "Sunny"],  // Commun00
        
        "EventDay00" : ["Clear", "Clear", "Sunny", "Clear", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Sunny", "Clear", "Sunny", "Clear", "Sunny", "Clear", "Sunny"],  // EventDay00
        
    ]
    
    public func findPattern(weather: [Int: String]) -> [String]{
        var possiblePatterns = patterns
        for pair in weather {
            for (index, pattern) in possiblePatterns.enumerated() {
                if pattern.value[pair.key] != pair.value {
                    possiblePatterns.removeValue(forKey: pattern.key)
                }
            }
        }
        var returnPatterns = [String]()
        for pattern in possiblePatterns {
            returnPatterns.append(pattern.key)
        }
        return returnPatterns
    }
    
 
}
