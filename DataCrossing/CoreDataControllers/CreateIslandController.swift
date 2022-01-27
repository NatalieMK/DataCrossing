//
//  CreateIslandController.swift
//  DataCrossing
//
//  Created by Natalie on 1/9/22.
//

import Foundation

enum CreateIslandControllerError: Error {
    case invalidSeed
    case nameTooShort
    case nameTooLong
    case negativeSeed
}

class CreateIslandController{
    
    public func createIsland(islandName: String, hemi: Int, doesTimeTravel: Bool, islandDate: Date?, seed: String?) throws {
        
        let island = IslandDataController()
        var seedNum: Int32? = nil
        let addedAt: Date = Date()
        var currentIslandDate: Date = Date()
        
        // Check name
        guard islandName.count <= 10 else {
            throw CreateIslandControllerError.nameTooLong
        }
        guard islandName.count >= 1 else {
            throw CreateIslandControllerError.nameTooShort
        }
        
        // No error should occur here, user input is confined to time scroller and switch.
        if (islandDate != nil) {
            currentIslandDate = islandDate!
        } else {
            currentIslandDate = Date()
        }

        // Set a non-nil weather seed
        if (seed != nil) {
            // cast seed as Int32. All weather seeds must be of Int32.
            guard let seedInt = Int32(seed!) else {
                throw CreateIslandControllerError.invalidSeed
            }
            // All weather seeds must also be positive
            guard seedInt > 0 else {
                throw CreateIslandControllerError.negativeSeed
            }
            seedNum = seedInt
        }

        do{
            try island.saveIsland(name: islandName, hemisphere: Int16(hemi), doesTimeTravel: doesTimeTravel, seed: seedNum, addedAt: addedAt, currentIslandDate: currentIslandDate)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
}
