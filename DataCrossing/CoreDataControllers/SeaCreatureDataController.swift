//
//  SeaCreatureDataController.swift
//  DataCrossing
//
//  Created by Natalie on 12/22/21.
//

import Foundation
import Kingfisher
import SwiftCSV
import CoreData

enum SeaCreatureDataControllerError: Error {
    case failToLoadFile
    case errorLoadingData
    case errorCreatingSeaCreature
    case errorAccessingCoreData
}

class SeaCreatureDataController: CritterDataController{
    
    var allCreatures = [SeaCreatureInfo]()
    var creatureDataFile: CSV?
    
    func initSeaCreatureData() throws{
        do {
            let csv: CSV? = try CSV(name: "CreatureData.csv")
            creatureDataFile = csv
        }
        catch {
            throw SeaCreatureDataControllerError.failToLoadFile
        }
        do {
            try creatureDataFile?.enumerateAsDict{ [self] dict in
                do { try addSeaCreature(dictionary: dict)
                } catch {
                    print("Error creating Sea Creature")
                }
            }
        }
        catch {
            throw SeaCreatureDataControllerError.errorLoadingData
        }
    }
    
    func addSeaCreature(dictionary: [String: String]) throws {
        
        let error = SeaCreatureDataControllerError.errorLoadingData
        var available : [String:String] = [:]
    
        let num = getCritterData(dictionary: dictionary, key: "number")!
        let name = getCritterData(dictionary: dictionary, key: "name")!
        let url = getCritterData(dictionary: dictionary, key: "url")!
        let size = getCritterData(dictionary: dictionary, key: "size")!
        
        dictionary.forEach {key, value in
            if (key.contains("N_") || key.contains("S_")){
                available[key] = value
            }
        }
        
        let seaCreaturey = SeaCreatureInfo(number: Int(num) ?? 0, name: name, url: URL(string: url) ?? nil, size: size, available: available)
        allCreatures.append(seaCreaturey)
        
        
        do {
            let isSaved = try checkIsCritter(name: name)
            if !isSaved {
                try createSeaCreature(name: name)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func getCaughtSeaCreatures() -> [SeaCreature?] {
        var creatures = [Critter?]()
        do {
            creatures = try getCaughtList()
        }
        catch {
        }
        return creatures as! [SeaCreature?]
    }
    
    func getUncaughtSeaCreatures() -> [SeaCreature?] {
        var creatures = [Critter?]()
        do {
            creatures = try getUncaughtList()
        }
        catch {
        }
        return creatures as! [SeaCreature?]
    }

    // MARK: - Core Data Implementation
    
    func createSeaCreature(name: String) throws {
        let creature = SeaCreature(context: mainContext)
        creature.name = name
        creature.hasBeenCaught = false
        do {
            try mainContext.save()
        } catch {
            throw SeaCreatureDataControllerError.errorCreatingSeaCreature
        }
    }
    
    func catchSeaCreature(name: String) {
        catchCritterNamed(name: name)
    }
    
    func catchSeaCreature(creature: SeaCreature) {
        catchCritterNamed(name: creature.name)
    }
    
    func uncatchSeaCreature(name: String){
        uncatchCritterNamed(name: name)
    }

    
    
    
    // Getters
    override func getSaved() throws -> [Critter] {
        var creatures = [SeaCreature]()
        do {
            creatures = try mainContext.fetch(SeaCreature.fetchRequest())
        } catch {
            throw SeaCreatureDataControllerError.errorAccessingCoreData
        }
        return creatures
    }
    
    func getSavedCreature() -> [SeaCreature] {
        var creatures = [Critter]()
        do {
            creatures = try getSaved()
        } catch {
            print(error.localizedDescription)
        }
        return creatures as! [SeaCreature]
    }
    
    func getCreatureNamed(name: String) -> SeaCreature? {
        var creature = SeaCreature()
        do {
            creature = try getCritterNamed(name: name) as! SeaCreature
        } catch {
            print(error.localizedDescription)
        }
        return creature
    }
    
}
