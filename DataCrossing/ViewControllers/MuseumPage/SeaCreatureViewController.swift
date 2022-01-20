//
//  SeaCreatureViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/15/21.
//

import UIKit
import Kingfisher

protocol SeaCreatureViewControllerDelegate {
    func didTapSeaCreature(creature: SeaCreature, index: Int)
        
}
class SeaCreatureViewController: UIViewController {
    
    let creatureDataControl = SeaCreatureDataController()
    var creatureDelegate: SeaCreatureViewControllerDelegate!
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try creatureDataControl.initSeaCreatureData()
        } catch {
            print("error")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNavBar()
        view.addSubview(collectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(popUpInfo))
        navigationItem.rightBarButtonItem?.tintColor = .acWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.frame
        collectionView.backgroundColor = .sand
        collectionView.register(MuseumItemCollectionViewCell.self, forCellWithReuseIdentifier: MuseumItemCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewFrame = CGRect(x: 10, y: 100, width: view.width - 20, height: view.height - 180)
        collectionView.frame = collectionViewFrame
    }
    
    @objc func popUpInfo(){
        let alert = UIAlertController(title: "Museum Screens", message: "Hold on an icon to mark the critter as CAUGHT.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil )
        
    }
}

extension SeaCreatureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creatureDataControl.allCreatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MuseumItemCollectionViewCell.identifier, for: indexPath) as! MuseumItemCollectionViewCell
        cell.imageView.kf.setImage(with: creatureDataControl.allCreatures[indexPath.row].url)
        let name = creatureDataControl.allCreatures[indexPath.row].name
        do {
            let creature = creatureDataControl.getCreatureNamed(name: name)
            if creature != nil {
                if (creature?.hasBeenCaught == true) {
                    cell.contentView.layer.opacity = 0.5
                } else {
                    cell.contentView.layer.opacity = 1.0
                }
            } else {cell.imageView.image = nil}
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector (self.handleLongPress))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = creatureDataControl.allCreatures[indexPath.row].name
        let creature = creatureDataControl.getCreatureNamed(name: name)
        if (creature != nil) {
            creatureDelegate.didTapSeaCreature(creature: creature!, index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width/6, height: view.width/6)
    }
}

extension SeaCreatureViewController: UIGestureRecognizerDelegate {
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != .ended {
            return
        }
        let location = gesture.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: location) {
            let cell = self.collectionView.cellForItem(at: indexPath)
            print ("Been held")
            self.present(makeAlert(indexPath: indexPath), animated: true, completion: nil)
        } else {
            print("couldn't find index path")
        }
    }
    func makeAlert(indexPath: IndexPath) -> UIAlertController{
        let alert = UIAlertController(title: "Catch!", message: "Catch this sea creature?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Catch", style: UIAlertAction.Style.default, handler: { [self] action in
            print("Caught")
            creatureDataControl.catchSeaCreature(name: creatureDataControl.allCreatures[indexPath.row].name)
            self.collectionView.reloadItems(at: [indexPath])
        }))
       return alert
    }
    
}
