//
//  PortraitLockedNavigationController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

class PortraitLockedNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait

    }
    
}
