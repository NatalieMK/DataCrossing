//
//  WeatherTableViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let identifier = "WeatherTableCell"
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let weatherText: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .acWhite
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.10
        label.font = UIFont(name: "telugusangammn-bold", size: 200)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(weatherImage)
        contentView.addSubview(weatherText)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        weatherImage.anchorToConstraints(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor).isActive = true
        weatherText.anchorToConstraints(top: contentView.topAnchor, leading: weatherImage.trailingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
