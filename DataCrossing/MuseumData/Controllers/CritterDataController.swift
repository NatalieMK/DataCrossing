//
//  CritterData.swift
//  DataCrossing
//
//  Created by Natalie on 12/24/21.
//

import Foundation
import SwiftCSV
import SwiftUI
import CoreData

enum CritterDataControllerError: Error {
    case errorAccessingCoreData
    case errorChangingCoreData
}

extension CritterDataControllerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorAccessingCoreData:
            return NSLocalizedString("Could not access core data", comment: "")
        case .errorChangingCoreData:
            return NSLocalizedString("Could not edit core data", comment: "")
        }
    }
}

class CritterDataController{
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext}
    
    // MARK: - Mutators
    func catchCritterNamed(name: String){
        do {
            var critter = try getCritterNamed(name: name)
            critter?.hasBeenCaught = true
            try mainContext.save()
        } catch CritterDataControllerError.errorAccessingCoreData {
            
        } catch {
            
        }
    }
    
    func uncatchCritterNamed(name: String){
        do {
            var critter = try getCritterNamed(name: name)
            critter?.hasBeenCaught = false
            try mainContext.save()
        } catch {
        }
    }
    
    // MARK: - Getters
    func getCritterData(dictionary: [String: String], key: String) -> String? {
        if let index = dictionary.firstIndex(where: { $0.0 == key}){
            return dictionary[index].1
        } else {
            return nil
        }
    }
    
    func getSaved() throws -> [Critter] {
        return [Critter]()
    }
    
    func getCaughtList() throws -> [Critter?]{
        var critters = [Critter]()
        var caughtCritters = [Critter?]()
        do {
            critters = try getSaved()
        } catch {
            throw CritterDataControllerError.errorAccessingCoreData
        }
        
        for critter in critters {
            if critter.hasBeenCaught {
                caughtCritters.append(critter)
            }
        }
        return caughtCritters
    }
    
    func getUncaughtList() throws -> [Critter?]{
        var critters = [Critter]()
        var uncaughtCritters = [Critter?]()
        do {
            critters = try getSaved()
        } catch {
            throw CritterDataControllerError.errorAccessingCoreData
        }
        
        for critter in critters {
            if !critter.hasBeenCaught {
                uncaughtCritters.append(critter)
            }
        }
        return uncaughtCritters
    }
    
    func getCritterNamed(name: String) throws -> Critter?{
        var critters = [Critter]()
        do {
            critters = try getSaved()
        } catch {
            throw CritterDataControllerError.errorAccessingCoreData
        }
        for critter in critters {
            if name == critter.name {
                return critter
            }
        }
        return nil
    }
    
    func checkIsCritter(name: String) throws -> Bool {
        var critters = [Critter]()
        do {
            critters = try getSaved()
        } catch {}
        for critter in critters {
            if name == critter.name{
                return true
            }
        }
        return false
    }
    
}

protocol Critter{
    var name: String {get}
    var hasBeenCaught: Bool {get set}
}
