//
//  WeatherEventCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class WeatherEventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherEventCollectionViewCell"
    
    let eventTimeLabel: UILabel = {
        let eventTimeLabel = UILabel()
        eventTimeLabel.font = UIFont(name: "telugusangammn-bold", size: 20)
       return eventTimeLabel
    }()
    
    let eventImage: UIImageView = {
        let eventImage = UIImageView()
        return eventImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(eventTimeLabel)
        contentView.addSubview(eventImage)
        eventTimeLabel.textColor = .acWhite
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        eventTimeLabel.frame = contentView.bounds
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
