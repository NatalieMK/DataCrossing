//
//  CritterSizeLabel.swift
//  DataCrossing
//
//  Created by Natalie on 1/22/22.
//

import UIKit

class CritterSizeLabel: UILabel {

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
        
        layoutSizeSymbols()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset(){
        for imageView in sizeImages {
            imageView.image = UIImage(systemName: "drop")
        }
    }
    
    func sizeChart(size: String){
        reset()
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
    
    func layoutSizeSymbols(){
        for imageView in sizeImages {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.anchorToConstraints(top: nil, leading: nil, trailing: nil, bottom: bottomAnchor)
            imageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8).isActive = true
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 8).isActive = true
            imageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
            imageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1/6).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true

            imageView.tintColor = .darkTeal
        }
        
        sizeImages[0].trailingAnchor.constraint(equalTo: sizeImages[1].leadingAnchor).isActive = true
        sizeImages[0].heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5).isActive = true
        sizeImages[0].heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 1/5).isActive = true
        
        sizeImages[1].trailingAnchor.constraint(equalTo: sizeImages[2].leadingAnchor).isActive = true
        sizeImages[1].widthAnchor.constraint(greaterThanOrEqualTo: sizeImages[0].widthAnchor, multiplier: 1.25).isActive = true
        sizeImages[1].widthAnchor.constraint(lessThanOrEqualTo: sizeImages[2].widthAnchor, multiplier: 0.8).isActive = true
        
        sizeImages[2].centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sizeImages[2].widthAnchor.constraint(greaterThanOrEqualTo: sizeImages[1].widthAnchor, multiplier: 1.25).isActive = true
        
        sizeImages[3].leadingAnchor.constraint(equalTo: sizeImages[2].trailingAnchor).isActive = true
        sizeImages[3].heightAnchor.constraint(lessThanOrEqualTo: sizeImages[4].heightAnchor).isActive = true
        sizeImages[3].heightAnchor.constraint(greaterThanOrEqualTo: sizeImages[2].heightAnchor, multiplier: 1.25).isActive = true
        
        
        sizeImages[4].heightAnchor.constraint(greaterThanOrEqualTo: sizeImages[3].heightAnchor, multiplier: 1.25).isActive = true
        sizeImages[4].leadingAnchor.constraint(equalTo: sizeImages[3].trailingAnchor).isActive = true
        sizeImages[4].heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, constant: 8).isActive = true
        
}
}

