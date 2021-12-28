//
//  Extensions.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import Foundation
import UIKit

extension UIView{
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat{
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat{
        return self.frame.origin.x
        
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
    
    public func autoLayoutView(field: UIView, topField: UIView?, heightConstant: CGFloat?, leadOffset: CGFloat?, trailOffset: CGFloat?, yOffset: CGFloat?){
        var constraints = [NSLayoutConstraint]()
        constraints.append(field.topAnchor.constraint(equalTo: topField?.bottomAnchor ?? self.topAnchor, constant: yOffset ?? 0))
        constraints.append(field.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leadOffset ?? 0))
        constraints.append(field.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -(trailOffset?.magnitude ?? 0)))
        if (heightConstant != nil) {
            constraints.append(field.heightAnchor.constraint(equalToConstant: heightConstant!))
        }
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIViewController{
    public func addNavBar(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.frame.size.width,
                                                   height: 100))
        navBar.backgroundColor = .coolGreen
        self.view.addSubview(navBar)
        navigationItem.titleView = UIImageView(image: UIImage(systemName: "leaf"))
        navigationItem.titleView?.tintColor = .acWhite
    }
}

extension Date{
    
    public func realTime(){
        let islandData = IslandDataController()
        let islandInit = islandData.getIslandInitDate()
        let currentDate = islandData.getIslandDate()
        let createdDate = islandData.getIslandCreatedAtDate()
        let interval = timeIntervalSince(createdDate)
        
        do {
            try islandData.updateIslandDate(newDate: Calendar.current.date(byAdding: .second, value: Int(interval), to: islandInit)!)
        } catch {
            print("Error updating time")
        }
        print("Island Time Updated: Current Time => \(islandData.getIslandDate())")
    }
}

