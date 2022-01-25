//
//  MuseumViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/14/21.
//

import UIKit
import simd

protocol MuseumViewControllerDelegate {
    func didTapMenuButton()
}

class MuseumViewController: UIViewController {

    var menuDelegate: MuseumViewControllerDelegate!
    let bugData = BugDataController()
    let fishData = FishDataController()
    let creatureData = SeaCreatureDataController()
    var bugsRemaining = [Bug?]()
    var fishRemaining = [Fish?]()
    var creaturesRemaining = [SeaCreature?]()
    
    let museumView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: MuseumViewController.buildLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sand
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNavBar()
        fishRemaining = fishData.getUncaughtFish()
        bugsRemaining = bugData.getUncaughtBugs()
        creaturesRemaining = creatureData.getUncaughtSeaCreatures()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .acWhite
        museumView.dataSource = self
        museumView.delegate = self
        view.addSubview(museumView)
        museumView.register(MuseumCounterCollectionViewCell.self, forCellWithReuseIdentifier: MuseumCounterCollectionViewCell.identifier)
    }
    
    @objc func didTapMenuButton(){
        menuDelegate?.didTapMenuButton()
    }
    
    override func viewDidLayoutSubviews() {
        museumView.frame = CGRect(x: 0, y: 100, width: view.width, height: view.height)
        museumView.backgroundColor = .sand
    }
    
}

extension MuseumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section){
        default:
            return 3

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = museumView.dequeueReusableCell(withReuseIdentifier: MuseumCounterCollectionViewCell.identifier, for: indexPath) as! MuseumCounterCollectionViewCell
            switch(indexPath.row){
            case 0:
                cell.numberLabel.text = "\(fishRemaining.count)"
                cell.logoView.image = UIImage(systemName: "tortoise.fill")
            case 1:
                cell.numberLabel.text = "\(creaturesRemaining.count)"
                cell.logoView.image = UIImage(systemName: "allergens")
            default:
                cell.numberLabel.text = "\(bugsRemaining.count)"
                cell.logoView.image = UIImage(systemName: "ladybug.fill")
            }
        
            return cell
        
    }
    
    static func buildLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            switch (sectionNumber) {
            default:
                let bugItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
                bugItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 10, bottom: 0, trailing: 10)
                let fishItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
                fishItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 10, bottom: 0, trailing: 10)
                let creatureItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
                creatureItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 10, bottom: 0, trailing: 10)
                let counterGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitems: [bugItem, fishItem, creatureItem])
                counterGroup.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 0, bottom: 10, trailing: 0)
                let counterSection = NSCollectionLayoutSection(group: counterGroup)
                return counterSection
            }

        }
    }
    
}
