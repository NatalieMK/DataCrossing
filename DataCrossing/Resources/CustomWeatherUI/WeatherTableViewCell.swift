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
        label.textAlignment = .center
        label.textColor = .acWhite
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.15
        label.font = UIFont(name: "telugusangammn-bold", size: 200)
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
        weatherImage.anchorToConstraints(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, insets: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
        weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor).isActive = true
        weatherText.anchorToConstraints(top: contentView.topAnchor, leading: contentView.centerXAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
