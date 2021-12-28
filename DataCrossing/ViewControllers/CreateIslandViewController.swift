//
//  CreateIslandViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/9/21.
//

import UIKit

protocol CreateIslandDelegate {
    func didCreateIsland()
}

class CreateIslandViewController: UIViewController {
    
    var islandDelegate: CreateIslandDelegate!
    var actionAllowed: Bool = false
    
    // MARK: - UI Declarations
    
    let titleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 35),
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.97, green: 0.83, blue: 0.35, alpha: 1.00),
        NSAttributedString.Key.strokeColor: UIColor.acBrown,
        NSAttributedString.Key.strokeWidth: -2.0,
    ]
    
    let fontAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.coolBrown,
        NSAttributedString.Key.font: UIFont(name: "KohinoorBangla-Semibold", size: 18),
        NSAttributedString.Key.backgroundColor: UIColor.clear]

    let buttonAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name:"AmericanTypewriter-Semibold", size: 20)
    ]
    
    let segmentedAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 18),
        NSAttributedString.Key.foregroundColor: UIColor.darkTeal]
    
    private let islandCreateButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCreateIsland), for: .touchUpInside)
        button.setTitle("Create Island", for: .normal)
        button.backgroundColor = .acBrown
        button.layer.borderColor = UIColor.paleBrown.cgColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.titleLabel?.textColor = .acWhite
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timeTravelText: UITextView = {
        let text = UITextView()
        text.text = "Do you time travel?"
        text.backgroundColor = nil
        text.isEditable = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let titleView: UITextView = {
        let text = UITextView()
        text.text = "Welcome to Paradise!"
        text.backgroundColor = nil
        text.isEditable = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let islandField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 0.75
        field.layer.borderColor = UIColor.coolBrown.cgColor
        field.placeholder = " Island Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let timeTravelView: ConditionalTimeSwitchViewController = {
        let time = ConditionalTimeSwitchViewController()
        time.view.translatesAutoresizingMaskIntoConstraints = false
        time.conditionalSwitch.backgroundColor = .brightBlue
        time.conditionalSwitch.selectedSegmentTintColor = .brightMint
        return time
    }()
    
    private let seedInfo: ConditionalTextSwitchViewController = {
       let seedView = ConditionalTextSwitchViewController()
        
        seedView.conditionalSwitch.backgroundColor = .brightBlue
        seedView.conditionalSwitch.selectedSegmentTintColor = .brightMint

        // Text Field
        seedView.conditionalField.autocorrectionType = .no
        seedView.conditionalField.autocapitalizationType = .none
        seedView.conditionalField.returnKeyType = .continue
        seedView.conditionalField.layer.cornerRadius = 12
        seedView.conditionalField.layer.borderWidth = 0.75
        seedView.conditionalField.layer.borderColor = UIColor.coolBrown.cgColor
        seedView.conditionalField.placeholder = " Seed Number"
        seedView.conditionalField.backgroundColor = nil

        seedView.view.translatesAutoresizingMaskIntoConstraints = false
        return seedView
    }()
    
    private let hemisphereText: UITextView = {
        let text = UITextView()
        text.text = "Island Hemisphere:"
        text.backgroundColor = nil
        text.isEditable = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let hemisphereInfo: UISegmentedControl = {
        let hemisphere = UISegmentedControl(items: ["Northern", "Southern"])
        hemisphere.backgroundColor = .brightBlue
        hemisphere.selectedSegmentTintColor = .brightMint
        hemisphere.translatesAutoresizingMaskIntoConstraints = false
        return hemisphere
    }()
    private let seedText: UITextView = {
        let text = UITextView()
        text.backgroundColor = nil
        text.text = "Do you know your island's weather seed?"
        text.isEditable = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sand
        seedInfo.conditionalField.delegate = self
        
        
        //Add Subviews
        view.addSubview(titleView)
        view.addSubview(islandField)
        view.addSubview(timeTravelText)
        view.addSubview(seedText)
        view.addSubview(seedInfo.view)
        view.addSubview(islandCreateButton)
        view.addSubview(timeTravelView.view)
        view.addSubview(hemisphereInfo)
        view.addSubview(hemisphereText)
        
        //
        seedText.attributedText = NSAttributedString(string: seedText.text, attributes: fontAttributes)
        timeTravelText.attributedText = NSAttributedString(string: timeTravelText.text, attributes: fontAttributes)
        hemisphereText.attributedText = NSAttributedString(string: hemisphereText.text, attributes: fontAttributes)
        islandCreateButton.setAttributedTitle(NSAttributedString(string: islandCreateButton.currentTitle!, attributes: buttonAttributes), for: .normal)
        seedInfo.conditionalSwitch.setTitleTextAttributes(segmentedAttributes, for: .normal)
        timeTravelView.conditionalSwitch.setTitleTextAttributes(segmentedAttributes, for: .normal)
        timeTravelView.titleLine.attributedText = NSAttributedString(string: "Current Island Time", attributes: fontAttributes)
        hemisphereInfo.setTitleTextAttributes(segmentedAttributes, for: .normal)
        titleView.attributedText = NSAttributedString(string: titleView.text, attributes: titleAttributes)
        
        //Layout Subviews
        view.autoLayoutView(field: titleView, topField: nil, heightConstant: 60, leadOffset: 20, trailOffset: 20, yOffset: 100)
        view.autoLayoutView(field: islandField, topField: titleView, heightConstant: 50, leadOffset: 20, trailOffset: 20, yOffset: 30)
        view.autoLayoutView(field: hemisphereText, topField: islandField, heightConstant: 50, leadOffset: 20, trailOffset: 20, yOffset: 20)
        view.autoLayoutView(field: hemisphereInfo, topField: hemisphereText, heightConstant: 50, leadOffset: 20, trailOffset: 20, yOffset: 20)
        view.autoLayoutView(field: timeTravelText, topField: hemisphereInfo, heightConstant: 50, leadOffset: 20, trailOffset: 20, yOffset: 20)
        view.autoLayoutView(field: timeTravelView.view, topField: timeTravelText, heightConstant: 110, leadOffset: 20, trailOffset: 20, yOffset: 5)
        view.autoLayoutView(field: seedText, topField: timeTravelView.view, heightConstant: 50, leadOffset: 20, trailOffset: 20, yOffset: 20)
        view.autoLayoutView(field: seedInfo.view, topField: seedText, heightConstant: 110, leadOffset: 20, trailOffset: 20, yOffset: 5)
        view.autoLayoutView(field: islandCreateButton, topField: seedInfo.view, heightConstant: 50, leadOffset: 50, trailOffset: 50, yOffset: 20)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func didTapCreateIsland() throws {
        
        let island = IslandDataController()
        let islandName = islandField.text
        var seedNum: Int32?
        var givenDate: Date = Date()

        if (seedInfo.conditionalSwitch.selectedSegmentIndex == 0)
        && (seedInfo.conditionalField.text != nil){
            let seed = seedInfo.conditionalField.text
            guard let seedInt = Int32(seed!) else {
                print("Error")
                return
            }
            seedNum = seedInt
        } else {
            seedNum = nil
        }
        if (timeTravelView.conditionalSwitch.selectedSegmentIndex == 0){
            givenDate = timeTravelView.conditionalDate.date
        }
        let hemi = hemisphereInfo.selectedSegmentIndex
        do{
            try island.initIsland(name: islandName!, hemisphere: Int16(hemi), islandDate: givenDate, weatherSeed: seedNum)
            islandDelegate.didCreateIsland()
            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension CreateIslandViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}
