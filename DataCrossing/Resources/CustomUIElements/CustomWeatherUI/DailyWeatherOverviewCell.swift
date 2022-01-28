//
//  DailyWeatherOverviewCell.swift
//  DataCrossing
//
//  Created by Natalie on 1/24/22.
//

import UIKit

class DailyWeatherOverviewCell: UICollectionViewCell {
    
    static let identifier = "DailyWeatherCell"
    
    var island: IslandData?
    
    enum weatherOptions: String {
        case Clear = "sun.max"
        case RainClouds = "cloud.drizzle"
        case Sun = "sun.max.fill"
        case Rain = "cloud.rain"
        case Clouds = "smoke.fill"
        case HeavyRain = "cloud.heavyrain"
        case CloudFine = "cloud.sun.fill"
    }
    
    var islandDataController = IslandDataController()
    var meteoNook = MeteoNookController()
    var weekWeather = [String]()
    var dayWeather = ""
    
    let dayWeatherLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .coolMint
        label.minimumScaleFactor = 0.3
        label.font = UIFont(name: "telugusangammn-bold", size: 200)
        label.textAlignment = .center
        label.textColor = .acWhite
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let weatherTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.isUserInteractionEnabled = false
        table.backgroundColor = .coolMint
        return table
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.tintColor = .acWhite
        weatherImage.backgroundColor = nil
        return weatherImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .coolMint
        contentView.addSubview(dayWeatherLabel)
        getTodaysWeather()
        weatherTable.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        contentView.addSubview(weatherTable)
        contentView.addSubview(weatherImage)
        weatherTable.dataSource = self
        weatherTable.delegate = self
        dayWeatherLabel.text = dayWeather
        weatherImage.image = getWeatherImage(weather: dayWeather)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTodaysWeather(){
        dayWeather = meteoNook.weatherForDay()
        weekWeather = meteoNook.weatherForWeek()
    }
    
    func layout(){
        
        weatherImage.anchorToConstraints(top: contentView.topAnchor, leading: nil, trailing: nil, bottom: dayWeatherLabel.topAnchor, insets: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        
        dayWeatherLabel.anchorToConstraints(top: weatherImage.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.centerYAnchor)
        
        dayWeatherLabel.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 1/4).isActive = true
        
        // Square Image
        weatherImage.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        weatherImage.widthAnchor.constraint(greaterThanOrEqualTo: dayWeatherLabel.heightAnchor, multiplier: 2).isActive = true
        weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: dayWeatherLabel.centerXAnchor).isActive = true
        
        weatherTable.anchorToConstraints(top: dayWeatherLabel.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, insets: safeAreaInsets)
        
        
        
    }
    
    public func getWeatherImage(weather: String) -> UIImage{
        switch weather {
        case "Clear":
            return UIImage(systemName: weatherOptions.Clear.rawValue)!
        case "Sunny":
            return UIImage(systemName: weatherOptions.Sun.rawValue)!
        case "Cloudy":
            return UIImage(systemName: weatherOptions.Clouds.rawValue)!
        case "RainCloud":
            return UIImage(systemName: weatherOptions.RainClouds.rawValue)!
        case "Fine", "EventDay":
            return UIImage(systemName: weatherOptions.Sun.rawValue)!
        case "Cloud":
            return UIImage(systemName: weatherOptions.Clouds.rawValue)!
        case "Rain":
            return UIImage(systemName: weatherOptions.Rain.rawValue)!
        case "CloudRain":
            return UIImage(systemName: weatherOptions.HeavyRain.rawValue)!
        case "CloudFine":
            return UIImage(systemName: weatherOptions.CloudFine.rawValue)!
        case "HeavyRain":
            return UIImage(systemName: weatherOptions.HeavyRain.rawValue)!
        default:
            return UIImage(systemName: "questionmark")!
        }
    }

}

extension DailyWeatherOverviewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height/7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.weatherImage.image = getWeatherImage(weather: weekWeather[indexPath.row])
        
        let format = DateFormatter()
        format.dateFormat = "E"
        var date = islandDataController.getIslandDate()
        
        let text = format.string(from: Calendar.current.date(byAdding: .day, value: indexPath.row + 1, to: date ?? Date()) ?? Date())
        cell.weatherText.text = text
        cell.selectionStyle = .none
        cell.backgroundColor = .acWhite
        cell.weatherText.textColor = .coolMint
        cell.weatherImage.tintColor = .coolMint
       
        return cell
    }
    
    
}
