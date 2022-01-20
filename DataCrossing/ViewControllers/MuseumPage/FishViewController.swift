//
//  FishViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/15/21.
//

import UIKit
import SwiftCSV
import Kingfisher

protocol FishViewControllerDelegate {
    func didTapFish(fish: Fish, index: Int)
}

class FishViewController: UIViewController {
    
    var fishDelegate: FishViewControllerDelegate!
    
    let fishDataControl = FishDataController()
    let critterInfoVC = CritterInformationViewController()
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
            do {
            try fishDataControl.initFishData()
            } catch{
                print("error")
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNavBar()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(popUpInfo))
        collectionView.backgroundColor = .sand
        navigationItem.rightBarButtonItem?.tintColor = .acWhite
        collectionView.register(MuseumItemCollectionViewCell.self, forCellWithReuseIdentifier: MuseumItemCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewFrame = CGRect(x: 10, y: 100, width: view.width - 20, height: view.height - 180)
        collectionView.frame = collectionViewFrame
    }
}

extension FishViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fishDataControl.allFish.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Kingfisher will download and cache image if needed, or load from locale machine if not.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MuseumItemCollectionViewCell.identifier, for: indexPath) as! MuseumItemCollectionViewCell
                cell.imageView.kf.setImage(with: fishDataControl.allFish[indexPath.row].url)
        let name = fishDataControl.allFish[indexPath.row].name
        do {
        let fish = try fishDataControl.getFishNamed(name: name)
            if fish != nil {
                if fish?.hasBeenCaught == true {
                    cell.contentView.layer.opacity = 0.5
                } else {
                    cell.contentView.layer.opacity = 1.0
                }
            }
        }
        catch {
            print("Could not catch fish")
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector (self.handleLongPress))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = fishDataControl.allFish[indexPath.row].name
        let fish = fishDataControl.getFishNamed(name: name)
        if fish != nil {
            fishDelegate.didTapFish(fish: fish!, index: indexPath.row)
            } else  {
            print("Could not catch fish")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width/6, height: view.width/6)
    }
}

extension FishViewController {
    func presentInfo(){
        present(critterInfoVC, animated: true)
    }
}
extension FishViewController: UIGestureRecognizerDelegate {
    
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
        let alert = UIAlertController(title: "Catch!", message: "Catch this fish?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Catch", style: UIAlertAction.Style.default, handler: { [self] action in
            print("Caught")
            fishDataControl.catchFish(name: fishDataControl.allFish[indexPath.row].name)
            self.collectionView.reloadItems(at: [indexPath])
        }))
       return alert
    }
    
    @objc func popUpInfo(){
        let alert = UIAlertController(title: "Museum Screens", message: "Hold on an icon to mark the critter as CAUGHT.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil )
        
    }
}


