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
        collectionView?.register(DailyWeatherOverviewCell.self, forCellWithReuseIdentifier: DailyWeatherOverviewCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherOverviewCell.identifier, for: indexPath) as! DailyWeatherOverviewCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? .acWhite : .acBrown
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeArea = view.bounds.inset(by: view.safeAreaInsets)
        return CGSize(width: safeArea.width, height: safeArea.height)
    }
}
