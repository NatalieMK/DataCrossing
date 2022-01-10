//
//  CritterInformationViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/9/22.
//

import UIKit


class CritterInformationViewController: UIViewController {
    
    lazy var fishController = FishDataController()
    lazy var bugController = BugDataController()
    lazy var seaController = SeaCreatureDataController()
    
    var critter: Critter!
    var index: Int!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let foundLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .acBrown
        view.addSubview(nameLabel)
        view.addSubview(foundLabel)
        view.addSubview(sizeLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        loadViewData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Yay")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.frame = CGRect(x: 100, y: 100, width: view.width - 200, height: 50)
        foundLabel.frame =  CGRect(x: 100, y: 300, width: view.width - 200, height: 50)
        sizeLabel.frame = CGRect(x: 100, y: 500, width: view.width - 200, height: 50)
    }
    
    func loadViewData(){
        if let fish = critter as? Fish {
            do {
            try fishController.initFishData()
            } catch{}
            nameLabel.text = fishController.allFish[index].name
            foundLabel.text = fishController.allFish[index].foundWhere
            sizeLabel.text = fishController.allFish[index].size
        }
        
        if let bug = critter as? Bug {
            print("Bug")
        }
        
        if let creature = critter as? SeaCreature {
            print("creature")
        }
    }
    
    func showViewData(){
        
    }
}

