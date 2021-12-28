//
//  HourlyForecastCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 12/25/21.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    enum weatherOptions: String{
        case Clear = "sun.max"
        case Sunny = "sun.max.fill"
        case Cloudy = "smoke"
        case RainClouds = "cloud.fill"
        case Rain = "cloud.drizzle"
        case HeavyRain = "cloud.heavyrain"
        
    }
    static let identifier = "HourlyForecastCollectionViewCell"
    
    let hourAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 18),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.acWhite
    ]
    
    let hourLabel: UILabel = {
        let hour = UILabel()
        return hour
    }()
    
    let weatherAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 18),
        NSAttributedString.Key.foregroundColor: UIColor.acWhite
    ]
    
    let weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        return weatherLabel
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.tintColor = .acWhite
        return weatherImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(weatherImage)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(hourLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let hour = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        let weather = CGRect(x: contentView.width/2, y: 0, width: contentView.width/3, height: contentView.height)
        let image = CGRect(x: (contentView.width - contentView.height - 10), y: 0, width: contentView.height, height: contentView.height)
        hourLabel.frame = hour
        hourLabel.attributedText = NSAttributedString(string: hourLabel.text ?? "", attributes: hourAttributes)
        weatherLabel.frame = weather
        weatherLabel.attributedText = NSAttributedString(string: weatherLabel.text ?? "", attributes: weatherAttributes)
        weatherImage.frame = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        weatherLabel.text = nil
        weatherImage.image = nil
    }
    
    public func getWeatherImage(weather: String) -> UIImage{
        switch weather {
        case "Clear":
            return UIImage(systemName: weatherOptions.Clear.rawValue)!
        case "Sunny":
            return UIImage(systemName: weatherOptions.Sunny.rawValue)!
        case "Cloudy":
            return UIImage(systemName: weatherOptions.Cloudy.rawValue)!
        case "RainClouds":
            return UIImage(systemName: weatherOptions.RainClouds.rawValue)!
        case "Rain":
            return UIImage(systemName: weatherOptions.Rain.rawValue)!
        case "HeavyRain":
            return UIImage(systemName: weatherOptions.HeavyRain.rawValue)!
        default:
            return UIImage(systemName: "question")!
        }
    }
}
