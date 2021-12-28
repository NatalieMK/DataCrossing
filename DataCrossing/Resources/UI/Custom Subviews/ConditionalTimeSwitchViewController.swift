//
//  ConditionalTimeSwitchViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/18/21.
//

import UIKit

class ConditionalTimeSwitchViewController: UIViewController {
        
        public var conditionalSwitch: UISegmentedControl = {
            let segment = UISegmentedControl(items: ["Yes", "No"])
            segment.translatesAutoresizingMaskIntoConstraints = false
            return segment
        }()
        
        public var titleLine: UITextView = {
            let field = UITextView()
            field.isHidden = false
            field.backgroundColor = nil
            field.isEditable = false
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        
        public var conditionalDate: UIDatePicker = {
            let date = UIDatePicker()
            date.datePickerMode = .dateAndTime
            date.translatesAutoresizingMaskIntoConstraints = false
            return date
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = nil
            // Do any additional setup after loading the view.
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            view.addSubview(conditionalSwitch)
            view.addSubview(conditionalDate)
            view.addSubview(titleLine)
            
            view.autoLayoutView(field: conditionalSwitch, topField: nil, heightConstant: view.height/2 - 5, leadOffset: nil, trailOffset: nil, yOffset: 0)
            view.autoLayoutView(field: titleLine, topField: conditionalSwitch, heightConstant: view.height/2 - 5, leadOffset: nil, trailOffset: view.width/2, yOffset: 10)
            view.autoLayoutView(field: conditionalDate, topField: conditionalSwitch, heightConstant: view.height/2 - 5, leadOffset: view.width/2, trailOffset: nil, yOffset: 10)
            conditionalSwitch.addTarget(self, action: #selector(yesNoTapped(_:)), for: .valueChanged)

        }
    
        @objc func yesNoTapped(_ segmentedControl: UISegmentedControl){
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                conditionalDate.isEnabled = true
            case 1:
                conditionalDate.isEnabled = false
            default:
                break
            }
        }
    
    public func getDate() -> Date{
        return conditionalDate.date
    }
    
    public func getTime(){
        
    }
}
