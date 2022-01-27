//
//  CritterSizeCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 1/11/22.
//

import UIKit

class CritterSizeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CritterSizeCollectionViewCell"
    
    enum SizeSymbols: String, CaseIterable{
        case possibleSize
        case trueSize
       
    }
    
    var sizeImages = [UIImageView(image: UIImage(systemName: "drop")), UIImageView(image: UIImage(systemName: "drop")), UIImageView(image: UIImage(systemName: "drop")), UIImageView(image: UIImage(systemName: "drop")), UIImageView(image: UIImage(systemName: "drop"))]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var size = 20
        var xValue = contentView.width/3
        var yValue = contentView.height
        for imageView in sizeImages {
            contentView.addSubview(imageView)
            imageView.tintColor = .acWhite
            imageView.frame = CGRect(x: Int(xValue), y: Int(yValue) - size, width: size, height: size)
            size = size + 5
            xValue = xValue + CGFloat(size)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for imageView in sizeImages {
            imageView.image = UIImage(systemName: "drop")
        }
        print("done")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sizeChart(size: String){
        switch (size){
        case "xsmall":
            sizeImages[0].image = UIImage(systemName: imageName(size: .trueSize))
        case "small":
            sizeImages[1].image = UIImage(systemName: imageName(size: .trueSize))
        case "medium":
            sizeImages[2].image = UIImage(systemName: imageName(size: .trueSize))
        case "large":
            sizeImages[3].image = UIImage(systemName: imageName(size: .trueSize))
        case "xlarge", "xxlarge":
            sizeImages[4].image = UIImage(systemName: imageName(size: .trueSize))
        default:
           return
        }
    }
    
    func imageName(size: SizeSymbols) -> String{
        switch(size){
        case .possibleSize:
            return "drop"
        case .trueSize:
            return "drop.fill"

        }
    }
    
}
