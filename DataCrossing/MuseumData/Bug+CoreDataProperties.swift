//
//  Bug+CoreDataProperties.swift
//  
//
//  Created by Natalie on 12/24/21.
//
//

import Foundation
import CoreData


extension Bug {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bug> {
        return NSFetchRequest<Bug>(entityName: "Bug")
    }

    @NSManaged public var hasBeenCaught: Bool
    @NSManaged public var name: String

}
