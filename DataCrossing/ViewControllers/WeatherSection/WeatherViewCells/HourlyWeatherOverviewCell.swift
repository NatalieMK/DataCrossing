//
//  HourlyWeatherOverviewCell.swift
//  DataCrossing
//
//  Created by Natalie on 1/31/22.
//

import UIKit

class HourlyWeatherOverviewCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCell"
    
    var island: IslandData?
    
    var hourWeather = [String]()

    let hourView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: HourlyWeatherOverviewCell.buildLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hourView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        hourWeather = MeteoNookController().weatherForHours()
        contentView.addSubview(hourView)
        layoutView()
        hourView.delegate = self
        hourView.dataSource = self
        hourView.backgroundColor = .sand
    }
    
    func layoutView(){
        hourView.anchorToConstraints(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, insets: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HourlyWeatherOverviewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as! HourlyForecastCollectionViewCell
        let cellHour = Calendar.current.date(byAdding: .hour, value: indexPath.row, to: IslandDataController().getIslandDate()!)
        cell.hourLabel.text = cellHour!.formatted(date: .omitted, time: .shortened)
        cell.weatherLabel.text = hourWeather[indexPath.row]
        cell.backgroundColor = .paleBrown
        cell.weatherImage.image = cell.getWeatherImage(weather: hourWeather[indexPath.row])
        cell.layer.cornerRadius = 15
        return cell
    }
    
    static func buildLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch (sectionNumber) {
            default:
                let hour = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/12)))
                hour.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
                
                let hourGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)), subitem: hour, count: 12)
                hourGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let forecastSection = NSCollectionLayoutSection(group: hourGroup)
                
                return forecastSection
            }
        }
    }
}
