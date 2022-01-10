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
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 34),
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
        text.isScrollEnabled = false
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
        text.isScrollEnabled = false
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
        text.isScrollEnabled = false
        return text
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sand
        seedInfo.conditionalField.delegate = self
        
        view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -8.0).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant:  -8.0).isActive = true
    
        
        //Add Subviews
        contentView.addSubview(titleView)
        contentView.addSubview(islandField)
        contentView.addSubview(timeTravelText)
        contentView.addSubview(seedText)
        contentView.addSubview(seedInfo.view)
        contentView.addSubview(islandCreateButton)
        contentView.addSubview(timeTravelView.view)
        contentView.addSubview(hemisphereInfo)
        contentView.addSubview(hemisphereText)

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
        titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16.0).isActive = true

        contentView.autoLayoutView(field: islandField, topField: titleView, heightConstant: 50, leadOffset: 0, trailOffset: 8, yOffset: 30)
        
        contentView.autoLayoutView(field: hemisphereText, topField: islandField, heightConstant: 50, leadOffset: 0, trailOffset: 8, yOffset: 20)
        contentView.autoLayoutView(field: hemisphereInfo, topField: hemisphereText, heightConstant: 50, leadOffset: 0, trailOffset: 8, yOffset: 10)
        contentView.autoLayoutView(field: timeTravelText, topField: hemisphereInfo, heightConstant: 50, leadOffset: 0, trailOffset: 8, yOffset: 30)
        contentView.autoLayoutView(field: timeTravelView.view, topField: timeTravelText, heightConstant: 110, leadOffset: 0, trailOffset: 8, yOffset: 10)
        contentView.autoLayoutView(field: seedText, topField: timeTravelView.view, heightConstant: 50, leadOffset: 0, trailOffset: 8, yOffset: 20)
        contentView.autoLayoutView(field: seedInfo.view, topField: seedText, heightConstant: 110, leadOffset: 0, trailOffset: 8, yOffset: 10)

        islandCreateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        islandCreateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        islandCreateButton.topAnchor.constraint(equalTo: seedInfo.view.bottomAnchor, constant: 30).isActive = true
        islandCreateButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension CreateIslandViewController{
    
    @objc func didTapCreateIsland(){
        
        let island = CreateIslandController()
        let islandName = islandField.text!
        var givenDate: Date = Date()
        var hemi: Int
        var doesTimeTravel: Bool
        var seed: String?
        
        // Hemisphere is set. 0 == Northern, 1 == Southern
        if hemisphereInfo.selectedSegmentIndex == 1 ||
            hemisphereInfo.selectedSegmentIndex == 0 {
            hemi = hemisphereInfo.selectedSegmentIndex
        } else {
            showAlert(message: "Please select a hemisphere")
            return
        }
        
        // Check "Time Travel" switch.
        // If yes is selected, givenDate is reset to whatever date is chosen.
        if (timeTravelView.conditionalSwitch.selectedSegmentIndex == 0){
            givenDate = timeTravelView.conditionalDate.date
            doesTimeTravel = true
        } else if (timeTravelView.conditionalSwitch.selectedSegmentIndex == 1){
            doesTimeTravel = false
        } else {
            showAlert(message: "Please select if you time travel.")
            return
        }
        
        // Check "Know Weather Seed" switch.
        // If yes is selected, and the text input is not empty, save text as seed.
        if (seedInfo.conditionalSwitch.selectedSegmentIndex == 0) {
            if (seedInfo.conditionalField.text == ""){
                showAlert(message: "Please input seed. You can select NO if unsure.")
            } else {
                seed = seedInfo.conditionalField.text
            }
        } else if (seedInfo.conditionalSwitch.selectedSegmentIndex == 1) {
            // Otherwise, seed is nil
            seed = nil
        } else {
            showAlert(message: "Please select if you know your weather seed")
            return
        }
        
        do{
            // Call createIsland, further checking done in CreateIslandController.
            try island.createIsland(islandName: islandName, hemi: hemi, doesTimeTravel: doesTimeTravel, islandDate: givenDate, seed: seed)
            islandDelegate.didCreateIsland()
            dismiss(animated: true, completion: nil)
        }
        // Catch cases to present alerts.
        catch CreateIslandControllerError.nameTooShort{
            showAlert(message: "Island Name is Required")
        }
        catch CreateIslandControllerError.nameTooLong{
            showAlert(message: "Island Name can only be 10 characters or less")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CreateIslandViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}
