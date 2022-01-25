//
//  IslandDataViewController.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

protocol IslandDataViewControllerDelegate {
    func didTapMenuButton()
}

class IslandDataViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let data = IslandDataController()
    var meteoNook = MeteoNookController()
    var weekWeather = [String]()
    var hourWeather = [String]()
    var menuDelegate: IslandDataViewControllerDelegate!
    
    let islandView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: IslandDataViewController.buildLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .creamYellow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNavBar()
        if data.getIslandDate() != nil {
        weekWeather = meteoNook.weatherForWeek()
        hourWeather = meteoNook.weatherForHours()
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .acWhite
        
        islandView.dataSource = self
        islandView.delegate = self

        view.addSubview(islandView)
        islandView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.identifier)
        islandView.register(WeatherEventCollectionViewCell.self, forCellWithReuseIdentifier: WeatherEventCollectionViewCell.identifier)
        islandView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        islandView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        islandView.register(TourneyCollectionViewCell.self, forCellWithReuseIdentifier: TourneyCollectionViewCell.identifier)
    }
    
    func reloadData(){
        data.getIslandDate()!.realTime()
        islandView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        islandView.frame = CGRect(x: 0, y: 100, width: view.width, height: view.height)
        islandView.backgroundColor = .sand
    }
    
    
    @objc func didTapMenuButton(){
        menuDelegate?.didTapMenuButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 0
        case 1:
            return 7
        case 2:
            return 12
        case 3:
            return 2
        default:
            return 0
        }
    }
    
    let titleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 40),
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.97, green: 0.83, blue: 0.35, alpha: 1.00),
        NSAttributedString.Key.strokeColor: UIColor.acBrown,
        NSAttributedString.Key.strokeWidth: -2.0
    ]
    
    let weatherTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 20),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.acWhite
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = islandView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.width, height: cell.height))
            title.text = data.getIslandName()
            title.attributedText = NSAttributedString(string: title.text!, attributes: titleAttributes)
            title.sizeToFit()
            cell.contentView.addSubview(title)
            return cell
        case 1:
            let cell = islandView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.identifier, for: indexPath) as! DailyWeatherCollectionViewCell
            cell.layer.cornerRadius = 7.0
            cell.backgroundColor = UIColor(red: 0.97, green: 0.83, blue: 0.35, alpha: 1.00)
            let cellDate = Calendar.current.date(byAdding: .day, value: indexPath.row, to: data.getIslandDate()!)
            cell.dayLabel.text = cellDate!.formatted(date: .numeric, time: .omitted)
            cell.dayLabel.attributedText = NSAttributedString(string: cell.dayLabel.text!, attributes: weatherTextAttributes)
            cell.weatherImage.image = cell.getWeatherImage(weather: weekWeather[indexPath.row])
            return cell
        case 2:
            let cell = islandView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as! HourlyForecastCollectionViewCell
            let cellHour = Calendar.current.date(byAdding: .hour, value: indexPath.row, to: data.getIslandDate()!)
            cell.hourLabel.text = cellHour!.formatted(date: .omitted, time: .shortened)
            cell.weatherLabel.text = hourWeather[indexPath.row]
            cell.backgroundColor = .paleBrown
            cell.weatherImage.image = cell.getWeatherImage(weather: hourWeather[indexPath.row])
            return cell
        case 3: let cell = islandView.dequeueReusableCell(withReuseIdentifier: TourneyCollectionViewCell.identifier, for: indexPath) as! TourneyCollectionViewCell
            cell.layer.cornerRadius = 10
            switch indexPath.row {
            case 0:
                cell.backgroundColor = .salmon
                cell.setFishTourney()
            default: cell.backgroundColor = .coolMint
                cell.setBugOff()
            }
            return cell
        default:
            let cell = islandView.dequeueReusableCell(withReuseIdentifier: WeatherEventCollectionViewCell.identifier, for: indexPath) as! WeatherEventCollectionViewCell
            cell.backgroundColor = .paleBrown
            let date = data.getIslandDate()!
            cell.eventTimeLabel.text = "\(date.nextFishingTourney())"
            return cell
        }
    }
        
    
    static func buildLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch (sectionNumber) {
            case 0:
                let titleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                titleItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 10, bottom: 10, trailing: 0)
                let titleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/8)), subitem: titleItem, count: 1)
                let titleSection = NSCollectionLayoutSection(group: titleGroup)
                return titleSection
            case 1:
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
                
            case 2:
                
                let hour = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/10)))
                hour.contentInsets = NSDirectionalEdgeInsets()
                
                let hourGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/3)), subitem: hour, count: 10)
                hourGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

                let forecastSection = NSCollectionLayoutSection(group: hourGroup)
                
                return forecastSection
            case 3:
                let tourneyItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                tourneyItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let tourneyGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/8)), subitem: tourneyItem, count: 2)
                let tourneySection = NSCollectionLayoutSection(group: tourneyGroup)
                return tourneySection
            default:
                let eventItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)))
                
                eventItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let currentItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                
                currentItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let eventGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalHeight(1)),
                    subitems: [eventItem, eventItem ,eventItem])
                
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [currentItem, eventGroup])
                
                let eventSection = NSCollectionLayoutSection(group: nestedGroup)
                return eventSection
    
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
}
