//
//  CritterInformationViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/9/22.
//

import UIKit
import MapKit


class CritterInformationViewController: UIViewController {
    
    lazy var fishController = FishDataController()
    lazy var bugController = BugDataController()
    lazy var seaController = SeaCreatureDataController()
    lazy var csvFormatter = CSVFormatter()
    
    var critter: Critter!
    var index: Int!
    var size: String!
    
    var available : [String:String] = [:]
    
    var calendarView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CritterInformationViewController.buildCalendar())
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .acWhite
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let foundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .acWhite
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let northKeys = ["N_Jan","N_Feb","N_Mar",
                     "N_Apr","N_May","N_Jun","N_Jul",
                     "N_Aug","N_Sep","N_Oct","N_Nov","N_Dec"]
    let southKeys = ["S_Jan","S_Feb","S_Mar",
                     "S_Apr","S_May","S_Jun","S_Jul",
                     "S_Aug","S_Sep","S_Oct","S_Sov","S_Dec"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coolMint
        view.addSubview(nameLabel)
        view.addSubview(calendarView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        loadViewData()
        calendarView.dataSource = self
        calendarView.delegate = self

        calendarView.register(CritterCalendarCollectionViewCell.self, forCellWithReuseIdentifier: CritterCalendarCollectionViewCell.identifier)
        calendarView.register(CritterSizeCollectionViewCell.self, forCellWithReuseIdentifier: CritterSizeCollectionViewCell.identifier)
        calendarView.backgroundColor = nil
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.frame = CGRect(x: 100, y: 100, width: view.width - 200, height: 50)
        foundLabel.frame =  CGRect(x: 100, y: 200, width: view.width - 200, height: 50)
        calendarView.frame = CGRect(x: 8, y: 300, width: view.width - 16, height: view.height - 400)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadViewData(){
        if let fish = critter as? Fish {
            do {
            try fishController.initFishData()
            } catch{}
            nameLabel.text = fishController.allFish[index].name.capitalized
            view.addSubview(foundLabel)
            foundLabel.text = fishController.allFish[index].foundWhere.capitalized
            size = fishController.allFish[index].size
            available = fishController.allFish[index].available
            calendarView.reloadData()
        }
        
        if let bug = critter as? Bug {
            print("Bug")
            do {
                try bugController.initBugData()
            } catch{}
            nameLabel.text = bugController.allBugs[index].name.capitalized
            size = nil
            foundLabel.text = nil
            available = bugController.allBugs[index].available
            calendarView.reloadData()
        }
        
        if let creature = critter as? SeaCreature {
            print("creature")
            do{
                try seaController.initSeaCreatureData()
            } catch{}
            nameLabel.text = seaController.allCreatures[index].name.capitalized
            size = seaController.allCreatures[index].size
            foundLabel.text = nil
            available = seaController.allCreatures[index].available
            calendarView.reloadData()
        }
    }

    

    
    static func buildCalendar() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch(sectionNumber){
            case 0:
                let sizeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let sizegroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/6)), subitems: [sizeItem])
                sizegroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
                let sizeSection = NSCollectionLayoutSection(group: sizegroup)
                sizeSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
                return sizeSection
            default:
                let calendarItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6), heightDimension: .fractionalHeight(1)))
                let calendarGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/6)), subitem: calendarItem, count: 4)
                
                calendarGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                let calenderSection = NSCollectionLayoutSection(group: calendarGroup)
                calenderSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return calenderSection
            }
        }
    }
    
}

extension CritterInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            if (size != nil) {
                return 1
            }
            else {return 0}
        default: return 12
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.section){
        case 0:
            let cell = calendarView.dequeueReusableCell(withReuseIdentifier: CritterSizeCollectionViewCell.identifier, for: indexPath ) as! CritterSizeCollectionViewCell
            if (size != nil){
            cell.sizeChart(size: size)
            }
            cell.backgroundColor = nil
            return cell
            
        default:
            let cell = calendarView.dequeueReusableCell(withReuseIdentifier: CritterCalendarCollectionViewCell.identifier, for: indexPath) as! CritterCalendarCollectionViewCell
            cell.monthLabel.text = cell.setMonthIndex(monthNum: indexPath.row).rawValue

            switch (indexPath.section){
            case 0:
                cell.availabilityLabel.text = csvFormatter.formatTime(timeString:  CritterDataController().getCritterData(dictionary: available, key: northKeys[indexPath.row]) ?? "nil")
                switch (indexPath.row){
                case 2, 0, 1:
                    cell.monthLabel.backgroundColor = .brightBlue
                case 3, 4, 5:
                    cell.monthLabel.backgroundColor = .coolGreen
                case 6, 7, 8:
                    cell.monthLabel.backgroundColor = .darkMint
                case 9, 10, 11:
                    cell.monthLabel.backgroundColor = .coolBrown
                default:
                    cell.monthLabel.backgroundColor = .coolMint
                }
            default:
                cell.availabilityLabel.text = csvFormatter.formatTime(timeString: CritterDataController().getCritterData(dictionary: available, key: southKeys[indexPath.row]) ?? "nil")
                switch (indexPath.row){
                case 0, 1, 2:
                    cell.monthLabel.backgroundColor = .brightBlue
                case 3, 4, 5:
                    cell.monthLabel.backgroundColor = .coolGreen
                case 6, 7, 8:
                    cell.monthLabel.backgroundColor = .darkMint
                case 9, 10, 11:
                    cell.monthLabel.backgroundColor = .coolBrown
                default:
                    cell.monthLabel.backgroundColor = .salmon
                }
            }
            
            cell.backgroundColor = .acWhite
            print(indexPath.row)
            return cell
        }
    }
}

