//
//  Fish+CoreDataProperties.swift
//  
//
//  Created by Natalie on 12/22/21.
//
//

import Foundation
import CoreData


extension Fish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fish> {
        return NSFetchRequest<Fish>(entityName: "Fish")
    }

    @NSManaged public var hasBeenCaught: Bool
    @NSManaged public var name: String

}
