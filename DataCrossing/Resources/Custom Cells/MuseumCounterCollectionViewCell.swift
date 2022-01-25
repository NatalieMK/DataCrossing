//
//  MuseumCounterCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 12/27/21.
//

import UIKit

class MuseumCounterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MuseumCounterCollectionViewCell"
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    let numAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 50),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.acWhite
    ]
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.layer.cornerRadius = 7.0
        contentView.addSubview(logoView)
        contentView.addSubview(numberLabel)
        
        numberLabel.attributedText = NSAttributedString(string: numberLabel.text ?? "?", attributes: numAttributes)
        contentView.backgroundColor = .salmon
        logoView.tintColor = .acWhite
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageFrame = CGRect(x:contentView.width/3, y: 10, width: contentView.width/3, height: contentView.width/5)
        logoView.frame = imageFrame
        let numberFrame = CGRect(x: contentView.width/4, y: contentView.height/4, width: contentView.width/2, height: contentView.height/2)
        numberLabel.frame = numberFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        numberLabel.text = nil
        logoView.image = nil
    }
    
}
