//
//  MeteoNookCaller.swift
//  DataCrossing
//
//  Created by Natalie on 12/8/21.
//

import Foundation

final class MeteoNookCaller{
    
    static let call = MeteoNookCaller()
    
    func parse(to: String) -> String {
        let result = rust_parse(to)
        let swift_result = String(cString: result!)
        rust_parse_free(UnsafeMutablePointer(mutating: result))
        return swift_result
    }
    
    func getSeed(with jsonString: String) -> Int32 {
        return 0
    }
    
    func getDayWeather(with jsonString: String) -> String {
        let data: Data? = jsonString.data(using: .utf8)
        if let dayWeather = try? JSONDecoder().decode(Weather.self, from: data!){
            return dayWeather.self.weather
        } else {
        return ""
        }
        
    }
    
    func canDecode(with jsonString: String) -> Bool{
        let data: Data? = jsonString.data(using: .utf8)
        if (try? JSONDecoder().decode(Weather.self, from: data!)) != nil{
            return true
        }
        return false
    }
    
}


