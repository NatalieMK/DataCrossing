//
//  CritterInformationViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/9/22.
//

import UIKit
import MapKit

protocol CritterDelegate {
    func dismissWithButton()
}

class CritterInformationViewController: UIViewController {

    lazy var fishController = FishDataController()
    lazy var bugController = BugDataController()
    lazy var seaController = SeaCreatureDataController()
    lazy var csvFormatter = CSVFormatter()
    
    var critter: Critter!
    var index: Int!
    var size: String!
    var hemisphere: Int!
    var critterDelegate: CritterDelegate!
    
    var dataController = CritterDataController()

    
    var available : [String:String] = [:]
    var rain: String = ""
    
    var calendarView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CritterInformationViewController.buildCalendar())

    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .acWhite
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.darkMint.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let nameHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkTeal
        label.textAlignment = .center
        label.text = "Name"
        return label
    }()
    
    let foundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .acWhite
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.darkMint.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let foundHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkTeal
        label.text = "Found in"
        label.textAlignment = .center
        return label
    }()
    
    let sizeHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkTeal
        label.textAlignment = .center
        label.text = "Shadow Size"
        return label
    }()
    
    let sizeLabel: CritterSizeLabel = {
        let label = CritterSizeLabel()
        return label
    }()
    
    let catchingButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .darkTeal
        return button
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
        view.addSubview(nameHeader)
        view.addSubview(foundHeader)
        view.addSubview(foundLabel)
        view.addSubview(sizeLabel)
        view.addSubview(sizeHeader)
        view.addSubview(catchingButton)
        hemisphere = Int(IslandDataController().getIslandHemisphere()!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        loadViewData()

        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.register(CritterCalendarCollectionViewCell.self, forCellWithReuseIdentifier: CritterCalendarCollectionViewCell.identifier)

        calendarView.backgroundColor = nil
        calendarView.layer.borderWidth = 2
        calendarView.layer.borderColor = UIColor.darkTeal.cgColor
        calendarView.layer.cornerRadius = 30
        calendarView.isPagingEnabled = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        anchorViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func anchorViews(){
        
        nameHeader.anchorToConstraints(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: view.safeAreaInsets.bottom, left: 0, bottom: 0, right: 0))
        nameHeader.heightAnchor.constraint(lessThanOrEqualTo: nameLabel.heightAnchor).isActive = true
        nameHeader.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        
        nameLabel.anchorToConstraints(top: nameHeader.bottomAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        nameLabel.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 1/8).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 1/10).isActive = true

        foundHeader.anchorToConstraints(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        foundHeader.heightAnchor.constraint(equalTo: nameHeader.heightAnchor).isActive = true
    
        foundLabel.anchorToConstraints(top: foundHeader.bottomAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        foundLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
        sizeHeader.anchorToConstraints(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: sizeLabel.topAnchor)
        sizeHeader.heightAnchor.constraint(equalTo: foundHeader.heightAnchor).isActive = true
        
        sizeLabel.anchorToConstraints(top: view.centerYAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil)
        sizeLabel.heightAnchor.constraint(equalTo: calendarView.heightAnchor, multiplier: 0.5).isActive = true
        
        calendarView.anchorToConstraints(top: sizeLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 10, bottom: 0, right: 10))
        calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        catchingButton.anchorToConstraints(top: calendarView.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 16, bottom: view.safeAreaInsets.top, right: 16))
        catchingButton.heightAnchor.constraint(equalTo: calendarView.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    
    func loadViewData(){
        catchingButton.addTarget(self, action: #selector(didPressCatchButton), for: .touchUpInside)
        
        if critter.hasBeenCaught {
            catchingButton.setTitle("Uncatch", for: .normal)
        } else {
            catchingButton.setTitle("Catch", for: .normal)
        }
        
        if let fish = critter as? Fish {
            do {
            try fishController.initFishData()
            } catch{}
            dataController = fishController
            nameLabel.text = fishController.allFish[index].name.capitalized

            foundLabel.text = fishController.allFish[index].foundWhere.capitalized

            size = fishController.allFish[index].size
            sizeLabel.sizeChart(size: size)
            sizeLabel.isHidden = false
            foundHeader.isHidden = false
            foundLabel.isHidden = false
            sizeHeader.isHidden = false
            available = fishController.allFish[index].available
            calendarView.reloadData()
        }
        
        if let bug = critter as? Bug {
            do {
                try bugController.initBugData()
            } catch{}
            dataController = bugController
            nameLabel.text = bugController.allBugs[index].name.capitalized
            size = nil
            rain = bugController.allBugs[index].weather
            
            sizeLabel.isHidden = true
            foundLabel.text = nil
            foundHeader.isHidden = false
            foundHeader.text = "Found in rain?"
            foundLabel.isHidden = false
            foundLabel.text = csvFormatter.formatRainString(rainString: rain)
            sizeHeader.isHidden = true
            
            available = bugController.allBugs[index].available
            calendarView.reloadData()
        }
        
        if let creature = critter as? SeaCreature {
            do{
                try seaController.initSeaCreatureData()
            } catch{}
            dataController = seaController
            nameLabel.text = seaController.allCreatures[index].name.capitalized
            size = seaController.allCreatures[index].size
            foundLabel.text = nil
            sizeLabel.sizeChart(size: size)
            sizeLabel.isHidden = false
            foundHeader.isHidden = true
            foundLabel.isHidden = true
            sizeHeader.isHidden = false
            available = seaController.allCreatures[index].available
            calendarView.reloadData()
        }
    }
    
    @objc func didPressCatchButton(){
        let name = critter.name
        print(critter.hasBeenCaught)

        if critter.hasBeenCaught {
            dataController.uncatchCritterNamed(name: name)
        } else {
            dataController.catchCritterNamed(name: name)
        }
        critterDelegate.dismissWithButton()
        
        dismiss(animated: false, completion: nil)
    }

    
    static func buildCalendar() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch(sectionNumber){
            default:
                let calendarItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6), heightDimension: .fractionalHeight(1)))
                let calendarGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: calendarItem, count: 4)
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
        default: return 12
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch (indexPath.section){
        default:
            let cell = calendarView.dequeueReusableCell(withReuseIdentifier: CritterCalendarCollectionViewCell.identifier, for: indexPath) as! CritterCalendarCollectionViewCell
            cell.monthLabel.text = cell.setMonthIndex(monthNum: indexPath.row).rawValue

            switch (hemisphere){
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

