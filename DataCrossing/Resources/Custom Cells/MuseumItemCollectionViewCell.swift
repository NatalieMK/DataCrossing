//
//  MuseumItemCollectionViewCell.swift
//  DataCrossing
//
//  Created by Natalie on 12/20/21.
//

import UIKit

class MuseumItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MuseumItemCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.layer.cornerRadius = 2
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageFrame = CGRect(x:0, y:0, width: contentView.width, height: contentView.height)
        imageView.frame = imageFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
