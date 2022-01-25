//
//  WeatherViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/24/22.
//

import UIKit

protocol WeatherViewControllerDelegate {
    func didTapMenuButton()
}

class WeatherViewController: SwipingCollectionViewController {

    var weatherDelegate: WeatherViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        view.backgroundColor = .sand
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNavBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .acWhite
    }
    
    @objc func didTapMenuButton(){
        weatherDelegate?.didTapMenuButton()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .acWhite : .acBrown
        return cell
    }
}




