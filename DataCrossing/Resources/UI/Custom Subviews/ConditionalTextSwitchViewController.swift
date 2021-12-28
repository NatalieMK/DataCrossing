//
//  ConditionalTextSwitchViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/17/21.
//

import UIKit

class ConditionalTextSwitchViewController: UIViewController {
    
    public var conditionalSwitch: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Yes", "No"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    public var conditionalField: UITextField = {
        let field = UITextField()
        field.isHidden = false
        field.backgroundColor = .acWhite
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nil
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(conditionalSwitch)
        view.addSubview(conditionalField)
        view.autoLayoutView(field: conditionalSwitch, topField: nil, heightConstant: view.height/2 - 5, leadOffset: nil, trailOffset: nil, yOffset: 0)
        view.autoLayoutView(field: conditionalField, topField: conditionalSwitch, heightConstant: view.height/2 - 5, leadOffset: nil, trailOffset: nil, yOffset: 10)
        conditionalSwitch.addTarget(self, action: #selector(yesNoTapped(_:)), for: .valueChanged)
    }
    
    @objc func yesNoTapped(_ segmentedControl: UISegmentedControl){
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            conditionalField.isHidden = false
            conditionalField.setNeedsDisplay()
        case 1:
            conditionalField.isHidden = true
            conditionalField.setNeedsDisplay()
        default:
            break
        }
    }
    
    func getText() -> String? {
        return conditionalField.text
    }

}
