//
//  WeatherCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
 
//    var weatherSeed -> data for completed weather seeds
    static let identifier = "WeatherCollectionViewCell"
    
    let dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.font = UIFont(name: "telugusangammn-bold", size: 25)
        dayLabel.textColor = .acWhite
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
    
}
