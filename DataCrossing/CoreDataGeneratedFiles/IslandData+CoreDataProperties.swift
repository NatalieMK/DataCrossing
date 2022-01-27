//
//  IslandData+CoreDataProperties.swift
//  DataCrossing
//
//  Created by Natalie on 12/9/21.
//
//

import Foundation
import CoreData


extension IslandData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IslandData> {
        return NSFetchRequest<IslandData>(entityName: "IslandData")
    }

    @NSManaged public var islandName: String?
    @NSManaged public var hemisphere: Int16
    @NSManaged public var addedAt: Date?
    @NSManaged public var seed: Int32
    @NSManaged public var doesTimeTravel: Bool
    @NSManaged public var currentIslandDate: Date?
    @NSManaged public var initIslandDate: Date?
    
    
}

extension IslandData : Identifiable {

}
