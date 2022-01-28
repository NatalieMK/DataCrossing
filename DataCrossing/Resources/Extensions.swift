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
    
    public func anchorToView(view: UIView, insets: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right).isActive = true
    }
    
    public func anchorToConstraints(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, insets: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if top != nil {
            topAnchor.constraint(equalTo: top!, constant: insets.top).isActive = true
        }
        if leading != nil {
        leadingAnchor.constraint(equalTo: leading!, constant: insets.left).isActive = true
        }
        if trailing != nil {
        trailingAnchor.constraint(equalTo: trailing!, constant: -insets.right).isActive = true
        }
        if bottom != nil {
            bottomAnchor.constraint(equalTo: bottom!, constant: -insets.bottom).isActive = true
        }
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
    
    public func todaysIslandDate() -> Date{
        let islandData = IslandDataController(mainContext: CoreDataStack.shared.mainContext)
        let islandInit = islandData.getIslandInitDate()
        let currentDate = islandData.getIslandDate()
        let createdDate = islandData.getIslandCreatedAtDate()
        let interval = createdDate.timeIntervalSinceNow
        return (Calendar.current.date(byAdding: .second, value: Int(interval), to: islandInit)!)
    }
    
    public func realTime(){
        let islandData = IslandDataController()
        do {
            try islandData.updateIslandDate(newDate: todaysIslandDate())
        } catch {
            print("Error updating time")
        }
//        print("Island Time Updated: Current Time => \(islandData.getIslandDate())")
    }
}

