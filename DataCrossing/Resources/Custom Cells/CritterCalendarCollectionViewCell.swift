//
//  CritterCalendarCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 1/10/22.
//

import UIKit

class CritterCalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CritterCalendarCollectionViewCell"
    
    var month: months!
    
    enum months: String {
        case January = "Jan"
        case February = "Feb"
        case March = "March"
        case April = "April"
        case May = "May"
        case June = "June"
        case July = "July"
        case August = "Aug"
        case September = "Sept"
        case October = "Oct"
        case November = "Nov"
        case December = "Dec"
    }
    
    func setMonthIndex(monthNum: Int) -> months{
        switch monthNum {
        case 0: month = months.January
        case 1: month = months.February
        case 2: month = months.March
        case 3: month = months.April
        case 4: month = months.May
        case 5: month = months.June
        case 6: month = months.July
        case 7: month = months.August
        case 8: month = months.September
        case 9: month = months.October
        case 10: month = months.November
        default: month = months.December
        }
        return month
    }
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .coolMint
        label.textAlignment = .center
        return label
    }()
    
    let availabilityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .acWhite
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.month = months.January
        contentView.addSubview(monthLabel)
        contentView.addSubview(availabilityLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthLabel.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height/3)
        availabilityLabel.frame = CGRect(x: 0, y: contentView.height/2, width: contentView.width, height: contentView.height/3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
