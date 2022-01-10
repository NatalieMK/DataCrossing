//
//  BugDataController.swift
//  DataCrossing
//
//  Created by Natalie on 12/20/21.
//

import Foundation
import Kingfisher
import SwiftCSV
import CoreData

enum BugDataControllerError: Error {
    case failToLoadFile
    case errorLoadingData
    case errorCreatingBug
    case errorAccessingCoreData
}

class BugDataController: CritterDataController{
    
    var allBugs = [BugInfo]()
    var bugsDataFile: CSV?
    
    func initBugData() throws {
        do {
            let csv: CSV? = try CSV(name: "BugsData.csv")
            bugsDataFile = csv
        }
        catch {
            throw BugDataControllerError.failToLoadFile
        }
        do {
            try bugsDataFile?.enumerateAsDict{ [self] dict in
                do { try createBug(dictionary: dict)
                } catch {
                    print("Error creating bug")
                }
            }
        }
        catch {
            throw BugDataControllerError.errorLoadingData
        }
    }
    
    func createBug(dictionary: [String: String]) throws {

        var available : [String:String] = [:]
        let error = BugDataControllerError.errorLoadingData
        
        let num = getCritterData(dictionary: dictionary, key: "number")!
        let name = getCritterData(dictionary: dictionary, key: "name")!
        let url = getCritterData(dictionary: dictionary, key: "url")!
        let weather = getCritterData(dictionary: dictionary, key: "weather")!

        dictionary.forEach {key, value in
            if (key.contains("NH") || key.contains("SH")){
                available[key] = value
            }
        }
        
        let buggy = BugInfo(number: Int(num) ?? 0, name: name, url: URL(string: url) ?? nil, weather: weather, available: available)
        allBugs.append(buggy)
        
        do {
            let isSaved = try checkIsCritter(name: name)
            if !isSaved {
                try createBug(name: name)
            }
        } catch {
            throw BugDataControllerError.errorCreatingBug
        }
    }
    
    
    // MARK: - Core Data Implementation
    func createBug(name: String) throws {
        let bug = Bug(context: mainContext)
        bug.name = name
        bug.hasBeenCaught = false
        do {
            try mainContext.save()
        } catch {
            throw BugDataControllerError.errorCreatingBug
        }
    }
    
    func catchBug(name: String){
        catchCritterNamed(name: name)
    }
    
    func catchBug(bug: Bug){
        catchCritterNamed(name: bug.name)
    }
    
    func uncatchBug(name: String){
        catchCritterNamed(name: name)
    }
    
    
    // Getters
    override func getSaved() throws -> [Critter] {
        var bugs = [Bug]()
        do {
            bugs = try mainContext.fetch(Bug.fetchRequest())
        } catch {
            throw BugDataControllerError.errorAccessingCoreData
        }
        return bugs
    }
    
    func getSavedBugs() -> [Bug] {
        var bugs = [Critter]()
        do {
            bugs = try getSaved()
        } catch {
            print(error.localizedDescription)
        }
        return bugs as! [Bug]
    }
    
    func getBugNamed(name: String) -> Bug? {
        var bug = Bug()
        do {
            bug = try getCritterNamed(name: name) as! Bug
        } catch {
            print(error.localizedDescription)
        }
        return bug
    }
    
    func getCaughtBugs() -> [Bug?] {
        var bugs = [Critter?]()
        do {
            bugs = try getCaughtList()
        }
        catch {
        }
        return bugs as! [Bug?]
    }
    
    func getUncaughtBugs() -> [Bug?] {
        var bugs = [Critter?]()
        do {
            bugs = try getUncaughtList()
        }
        catch {
        }
        return bugs as! [Bug?]
    }
}
