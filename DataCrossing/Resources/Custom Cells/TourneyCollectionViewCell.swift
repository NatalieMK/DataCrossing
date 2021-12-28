//
//  TourneyCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 12/25/21.
//

import UIKit

class TourneyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TourneyCollectionViewCell"
    var islandDataControl = IslandDataController()
    
    let eventLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let eventAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 15),
        NSAttributedString.Key.foregroundColor: UIColor.acWhite
    ]
    
    let dateAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 20),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.acWhite
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)
        contentView.addSubview(eventLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tourney = CGRect(x: 5, y: 0, width: contentView.width, height: contentView.height/3)
        eventLabel.frame = tourney
        let date = CGRect(x: 5, y: tourney.height, width: contentView.width, height: contentView.height/2)
        dateLabel.frame = date
    }
    
    func setFishTourney(){
            eventLabel.attributedText = NSAttributedString(string: "Next Fishing Tourney", attributes: eventAttributes)
            let date = islandDataControl.getIslandDate()
            if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
                dateLabel.text = dateFormatter.string(from: date!.nextFishingTourney())
        } else {
            dateLabel.text = "Could not load dates"
        }
        dateLabel.attributedText = NSAttributedString(string: dateLabel.text ?? " ", attributes: dateAttributes)
    }
    
    func setBugOff(){
        eventLabel.attributedText = NSAttributedString(string: "Next Bug Off", attributes: eventAttributes)
        let date = islandDataControl.getIslandDate()
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateLabel.text = dateFormatter.string(from: date!.nextBugOff(hemisphere: 0))
        } else {
            dateLabel.text = "Could not load dates"
        }
        dateLabel.attributedText = NSAttributedString(string: dateLabel.text ?? " ", attributes: dateAttributes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
