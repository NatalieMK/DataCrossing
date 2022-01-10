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
    
    var available : [String:String] = [:]
    
    let calendarView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CritterInformationViewController.buildCalendar())
    
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
    
    let northKeys = ["N_Jan","N_Feb","N_Mar",
                     "N_Apr","N_May","N_Jun","N_Jul",
                     "N_Aug","N_Sep","N_Oct","N_Nov","N_Dec"]
    let southKeys = ["S_Jan","S_Feb","S_Mar",
                     "S_Apr","S_May","S_Jun","S_Jul",
                     "S_Aug","S_Sep","S_Oct","S_Sov","S_Dec"]
    

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
        calendarView.dataSource = self
        calendarView.delegate = self
        view.addSubview(calendarView)

        calendarView.register(CritterCalendarCollectionViewCell.self, forCellWithReuseIdentifier: CritterCalendarCollectionViewCell.identifier)
        calendarView.backgroundColor = .brightBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.frame = CGRect(x: 100, y: 100, width: view.width - 200, height: 50)
        foundLabel.frame =  CGRect(x: 100, y: 200, width: view.width - 200, height: 50)
        sizeLabel.frame = CGRect(x: 100, y: 300, width: view.width - 200, height: 50)
        calendarView.frame = CGRect(x: 8, y: 400, width: view.width - 16, height: view.height/2)
    }
    
    func loadViewData(){
        if let fish = critter as? Fish {
            do {
            try fishController.initFishData()
            } catch{}
            nameLabel.text = fishController.allFish[index].name
            foundLabel.text = fishController.allFish[index].foundWhere
            sizeLabel.text = fishController.allFish[index].size
            available = fishController.allFish[index].available
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
    
    static func buildCalendar() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let calendarItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6), heightDimension: .fractionalHeight(1)))
            let calendarGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitem: calendarItem, count: 4)
            calendarGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            let calenderSection = NSCollectionLayoutSection(group: calendarGroup)
            calenderSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return calenderSection
        }
    }
    
    
}

extension CritterInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarView.dequeueReusableCell(withReuseIdentifier: CritterCalendarCollectionViewCell.identifier, for: indexPath) as! CritterCalendarCollectionViewCell
        cell.monthLabel.text = cell.setMonthIndex(monthNum: indexPath.row).rawValue

        
        switch (indexPath.section){
        case 0:
            cell.availabilityLabel.text = CritterDataController().getCritterData(dictionary: available, key: northKeys[indexPath.row])
            switch (indexPath.row){
            case 2, 0, 1:
                cell.monthLabel.backgroundColor = .coolMint
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
            cell.availabilityLabel.text = CritterDataController().getCritterData(dictionary: available, key: southKeys[indexPath.row])
            switch (indexPath.row){
            case 0, 1, 2:
                cell.monthLabel.backgroundColor = .coolMint
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
        cell.layer.cornerRadius = 3.0
        cell.backgroundColor = .acWhite
        print(indexPath.row)
        return cell
    }
    
    

}

