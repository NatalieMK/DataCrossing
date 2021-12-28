//
//  SeaCreature+CoreDataProperties.swift
//  
//
//  Created by Natalie on 12/24/21.
//
//

import Foundation
import CoreData


extension SeaCreature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeaCreature> {
        return NSFetchRequest<SeaCreature>(entityName: "SeaCreature")
    }

    @NSManaged public var name: String
    @NSManaged public var hasBeenCaught: Bool

}
