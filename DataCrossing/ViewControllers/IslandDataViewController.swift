//
//  IslandDataViewController.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class IslandDataViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let weatherView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: IslandDataViewController.buildLayout()
    )
//    let eventView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: IslandDataViewController.buildLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .acWhite
        
        addNavBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .acWhite
        
        weatherView.dataSource = self
        weatherView.delegate = self
//        eventView.delegate = self
//        eventView.dataSource = self
//
        view.addSubview(weatherView)
//        view.addSubview(eventView)
        weatherView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        weatherView.register(WeatherEventCollectionViewCell.self, forCellWithReuseIdentifier: WeatherEventCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        weatherView.frame = CGRect(x: 0, y: 100, width: view.width, height: view.height)
        weatherView.backgroundColor = .acWhite
        
//        eventView.frame = CGRect(x: view.width/2, y: view.height/3 + 132 + 32, width: view.width/2, height: view.height/3)
//        eventView.backgroundColor = .acBrown
    }
    
    private func addNavBar(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0,
                                                   width: view.frame.size.width,
                                                   height: 100))
        navBar.backgroundColor = .coolGreen
        view.addSubview(navBar)
        navigationItem.titleView = UIImageView(image: UIImage(systemName: "leaf"))
        navigationItem.titleView?.tintColor = .acWhite
    }
    
    @objc func didTapMenuButton(){}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
        return 7
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0){
        let cell = weatherView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.layer.cornerRadius = 7.0
        cell.backgroundColor = .paleBrown
        cell.dayLabel.text = "DAY"
        cell.weatherImage.image = UIImage(systemName: "cloud.sun.fill")
        return cell
        } else {
            let cell = weatherView.dequeueReusableCell(withReuseIdentifier: WeatherEventCollectionViewCell.identifier, for: indexPath) as! WeatherEventCollectionViewCell
            cell.backgroundColor = .acBrown
            cell.eventTimeLabel.text = "Sample Event"
            return cell
        }
    }
    
    static func buildLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let forecastItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
                forecastItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let forecastGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/3),
                        heightDimension: .fractionalWidth(2/5)),
                    subitem: forecastItem,
                    count: 1)
                
                let forecastSection = NSCollectionLayoutSection(group: forecastGroup)
                forecastSection.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                forecastSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return forecastSection
            } else {
                
                let eventItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)))
                
                eventItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let currentItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                
                currentItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let eventGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalHeight(1)),
                    subitems: [eventItem, eventItem ,eventItem])
                
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitems: [currentItem, eventGroup])
                
                let eventSection = NSCollectionLayoutSection(group: nestedGroup)
                return eventSection
    
            }
        
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}
