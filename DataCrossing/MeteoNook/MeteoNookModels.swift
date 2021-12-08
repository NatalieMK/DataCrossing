//
//  MeteoNookModels.swift
//  DataCrossing
//
//  Created by Natalie on 12/7/21.
//

import Foundation

struct Date: Codable {
    var year: Int
    var day: Int
    var month: Int
    
}

struct Weather: Codable {
    var weather: String
}
