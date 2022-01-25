//
//  WeatherCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
 
    let weatherNames = [
    "sun.max.fill", "smoke.fill", "cloud.drizzle", "cloud.rain", "cloud.snow", "snowflake", "cloud.sun.fill" ]
    
    enum weatherOptions: String {
        case RainCloud = "cloud.drizzle"
        case Fine = "sun.max.fill"
        case Rain = "cloud.rain"
        case Cloud = "smoke.fill"
        case CloudRain = "cloud.snow"
        case CloudFine = "cloud.sun.fill"
    }
//    var weatherSeed -> data for completed weather seeds
    static let identifier = "DailyWeatherCollectionViewCell"
    
    let dayLabel: UILabel = {
        let dayLabel = UILabel()
        return dayLabel
    }()
    
    let weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.textColor = .acWhite
        return weatherLabel
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        return weatherImage
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(weatherLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let dayFrame = CGRect(x: 10, y: 0, width: contentView.width, height: contentView.height/2)
        dayLabel.frame = dayFrame
        let imageFrame = CGRect(x: contentView.width/2, y: dayLabel.frame.height, width: contentView.height/3, height: contentView.height/3)
        weatherImage.frame = imageFrame
        weatherImage.tintColor = .acWhite
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        weatherImage.image = nil
    }
    
    public func getRandomWeatherImage() -> UIImage{
        let randomName = weatherNames[Int.random(in: 0..<weatherNames.count)]
        return UIImage(systemName: randomName)!
    }
    
    public func getWeatherImage(weather: String) -> UIImage{
        switch weather {
        case "RainCloud":
            return UIImage(systemName: weatherOptions.RainCloud.rawValue)!
        case "Fine", "EventDay":
            return UIImage(systemName: weatherOptions.Fine.rawValue)!
        case "Cloud":
            return UIImage(systemName: weatherOptions.Cloud.rawValue)!
        case "Rain":
            return UIImage(systemName: weatherOptions.Rain.rawValue)!
        case "CloudRain":
            return UIImage(systemName: weatherOptions.CloudRain.rawValue)!
        case "CloudFine":
            return UIImage(systemName: weatherOptions.CloudFine.rawValue)!
        default:
            return UIImage(systemName: "question")!
        }
    }
}
