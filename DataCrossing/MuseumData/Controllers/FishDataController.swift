//
//  FishDataController.swift
//  DataCrossing
//
//  Created by Natalie on 12/20/21.
//

import Foundation
import SwiftCSV
import SwiftUI
import CoreData

enum FishDataControllerError: Error {
    case failToLoadFile
    case errorLoadingData
    case errorAccessingCoreData
    case errorSavingToCoreData
    case errorChangingCoreData
}

class FishDataController: CritterDataController{
    
    var allFish = [FishInfo]()
    var fishDataFile: CSV?
    
    func initFishData() throws{
        do {
            let csv: CSV? = try CSV(name: "FishData.csv")
            fishDataFile = csv
        }
        catch {
            throw FishDataControllerError.failToLoadFile
        }
        do {
            try fishDataFile?.enumerateAsDict{ [self] dict in
                do { try createFish(dictionary: dict)
                } catch {
                    print("Error creating fish")
                }
            }
        }
        catch {
            throw FishDataControllerError.errorLoadingData
        }
    }
    
    func createFish(dictionary: [String: String]) throws {
        
        var available : [String:String] = [:]
    
        let num = getCritterData(dictionary: dictionary, key: "number")!
        let name = getCritterData(dictionary: dictionary, key: "name")!
        let url = getCritterData(dictionary: dictionary, key: "url")!
        let foundWhere = getCritterData(dictionary: dictionary, key: "location")!
        let size = getCritterData(dictionary: dictionary, key: "size")!
        
        dictionary.forEach {key, value in
            if (key.contains("N_") || key.contains("S_")){
                available[key] = value
            }
        }
        let fishy = FishInfo(number: Int(num) ?? 0, name: name, url: URL(string: url) ?? nil, foundWhere: foundWhere, size: size, available: available)
        
        allFish.append(fishy)
        
        do {
            let isSaved = try checkFish(name: name)
            if !isSaved {
                try createFish(name: name)
            }
        } catch {
            throw FishDataControllerError.errorSavingToCoreData
        }
    }


// MARK: - Core Data Implementation

    
    func createFish(name: String) throws{
        let fish = Fish(context: mainContext)
        fish.name = name
        fish.hasBeenCaught = false
        do {
            try mainContext.save()
        } catch {
            throw FishDataControllerError.errorSavingToCoreData
        }
    }
    
    func catchFish(name: String){
        catchCritterNamed(name: name)
    }
    
    func catchFish(fish: Fish){
        catchCritterNamed(name: fish.name)
    }
    
    func uncatchFishNamed(name: String) throws{
        uncatchCritterNamed(name: name)
    }
    
    // Verifies if a fish by that name has already been saved to CoreData
    func checkFish(name: String) throws -> Bool {
        do {
            return try checkIsCritter(name: name)
        } catch {
            throw FishDataControllerError.errorAccessingCoreData
        }
    }
    

    
    // Getters
    
    override func getSaved() throws -> [Critter] {
        var fishes = [Fish]()
        do {
            fishes = try mainContext.fetch(Fish.fetchRequest())
        } catch {
            throw FishDataControllerError.errorAccessingCoreData
        }
        return fishes
    }
    
    func getSavedFish() -> [Fish] {
        var fishes = [Critter]()
        do {
            fishes = try getSaved()
        } catch {
            print(error.localizedDescription)
        }
        return fishes as! [Fish]
    }
    
    // Access fish by name
    func getFishNamed(name: String) -> Fish? {
        var fish = Fish()
        do {
            fish = try getCritterNamed(name: name) as! Fish
        } catch {
            print(error.localizedDescription)
        }
        return fish
    }
    
    func getCaughtFish() -> [Fish?] {
        var fishes = [Critter?]()
        do {
            fishes = try getCaughtList()
        }
        catch {
        }
        return fishes as! [Fish?]
    }
    
    func getUncaughtFish() -> [Fish?]{
        var fishes = [Critter?]()
        do {
            fishes = try getUncaughtList()
        } catch {
        }
        return fishes as! [Fish?]
    }
    
}
