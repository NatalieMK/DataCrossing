//
//  MuseumModels.swift
//  DataCrossing
//
//  Created by Natalie on 12/19/21.
//

import Foundation

struct FishInfo{
 
    var number: Int
    var name: String
    var url: URL?
    var foundWhere: String
    var size: String
    var available: [String:String]
}

struct BugInfo{
    var number: Int
    var name: String
    var url: URL?
    var weather: String
    var available: [String:String]
}

struct SeaCreatureInfo{
    var number: Int
    var name: String
    var url: URL?
    var size: String
    var available: [String:String]
}
