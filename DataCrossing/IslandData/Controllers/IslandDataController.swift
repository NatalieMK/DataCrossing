//
//  IslandDataController.swift
//  DataCrossing
//
//  Created by Natalie on 12/9/21.
//

import Foundation
import UIKit
import CoreData


enum IslandDataControllerError: Error{
    case unknownError
    case couldNotRetrieveIsland
    case invalidSeed
    case nameTooLong
    case nameTooShort
}

class IslandDataController{
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }

    // Returns if there is a user-saved island in core data.
    func isSavedIsland() throws -> Bool {
        do {
            let islands = try mainContext.fetch(IslandData.fetchRequest())
            if islands.isEmpty {
                return false
            } else {
                return true
            }
        } catch {
            throw IslandDataControllerError.unknownError
        }
    }
    
    // Returns user-saved island data
    func getSavedIsland() throws -> IslandData {
        var islands = [IslandData]()
        do {
            islands = try mainContext.fetch(IslandData.fetchRequest())
        } catch {
            throw IslandDataControllerError.couldNotRetrieveIsland
        }
        return islands[0]
    }
    

    // Parameters:
    // name: String => name of island.
    // hemisphere: Int16 => represents hemisphere of island. 0: Northern, 1: Southern
    // doesTimeTravel: Bool => user indicated that they do or do not time travel on island.
    // seed: Int32? => island weather seed. Left nil if unknown.
    // addedAt: Date => date that island was created *in app*. This is used to keep track of time passed, regardless of time on island. This cannot be changed. Set to current by default.
    // currentIslandDate => current island date at moment of creation. This can be changed. Set to current date by default.
    
    func saveIsland(name: String, hemisphere: Int16, doesTimeTravel: Bool, seed: Int32?, addedAt: Date, currentIslandDate: Date) throws{
        let userIsland = IslandData(context: mainContext)
        
        userIsland.islandName = name
        userIsland.hemisphere = hemisphere
        userIsland.doesTimeTravel = doesTimeTravel
        if seed != nil {
            userIsland.seed = seed!
        }
        
        userIsland.addedAt = addedAt
        userIsland.currentIslandDate = currentIslandDate
        
        do {
            try mainContext.save()
        } catch
        {
            throw IslandDataControllerError.unknownError
        }
        
    }
    
    // Updates the weather seed number for user island
    func updateIslandSeed(newSeed: Int32) throws {
        // Weather seed must be positive and within the Int32 range
        guard newSeed >= 0 else {
            throw IslandDataControllerError.invalidSeed
        }
        do {
            let island = try getSavedIsland()
            island.seed = newSeed
            try mainContext.save()
        } catch {
            throw IslandDataControllerError.unknownError
        }
    }
    
    func updateIslandDate(newDate: Date) throws{
        do{
            let savedIsland = try getSavedIsland()
            savedIsland.currentIslandDate = newDate
            try mainContext.save()
        } catch {
           throw IslandDataControllerError.unknownError
        }
    }
    
    // MARK: - Getters
    
    // Return name of active user island
    
    func getIslandName() -> String? {
        do {
            let island = try getSavedIsland()
            return island.islandName!
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getIslandCreatedAtDate() -> Date {
        var island = IslandData()
        do {
            island = try getSavedIsland()
        } catch {
        }
        return island.addedAt!
    }
    
    func getIslandInitDate() -> Date {
        var island = IslandData()
        do {
            island = try getSavedIsland()
            if island.doesTimeTravel {
                return island.initIslandDate!
            }
        } catch {
        }
        return getIslandCreatedAtDate()
    }
    
    // Return date of active user island
    func getIslandDate() -> Date? {
        do {
            let island = try getSavedIsland()
            return island.currentIslandDate!
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getIslandHemisphere() -> Int16? {
        do {
            let island = try getSavedIsland()
            return island.hemisphere
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension IslandDataControllerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Error has occurred", comment: "")
        case .invalidSeed:
            return NSLocalizedString("Weather seed is invalid", comment: "")
        case .nameTooLong:
            return NSLocalizedString("Island name must be less than 10 characters", comment: "")
        case .nameTooShort:
            return NSLocalizedString("Island name is required", comment: "")
        case .couldNotRetrieveIsland:
            return NSLocalizedString("An error has occurred while retrieving your island", comment: "")
        }
    }
}

extension IslandDataController {
    // Overloaded functions where IslandData object is provided, and does not need to be retrieved
    
    func getIslandName(island: IslandData) -> String {
        return island.islandName!
    }
    
    func getIslandDate(island: IslandData) -> Date {
        return island.currentIslandDate!
    }

    func getIslandHemisphere(island: IslandData) -> Int16 {
        return island.hemisphere
    }
    
    // Updates the weather seed number for user island
    func updateIslandSeed(island: IslandData, newSeed: Int32) throws {
        // Weather seed must be positive and within the Int32 range
        guard newSeed >= 0 else {
            throw IslandDataControllerError.invalidSeed
        }
        
        island.seed = newSeed
        do {
            try mainContext.save()
        } catch {
            throw IslandDataControllerError.unknownError
        }
    }
    
    func updateIslandDate(island: IslandData?, newDate: Date) throws{
        if (island != nil){
            island!.currentIslandDate = newDate
        } else {
            let savedIsland = try getSavedIsland()
            savedIsland.currentIslandDate = newDate
        }
        do{
            try mainContext.save()
        } catch {
           throw IslandDataControllerError.unknownError
        }
    }
    
}

