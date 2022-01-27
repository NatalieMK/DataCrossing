//
//  AddWeatherItemViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

class AddWeatherItemViewController: UIViewController {
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finish", for: .normal)
        button.backgroundColor = .acBrown
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brightYellow
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(didSelectBack))
        navigationItem.leftBarButtonItem?.tintColor = .acBrown
            }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(doneButton)
        doneButton.anchorToConstraints(top: view.topAnchor, leading: nil, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 16))
        doneButton.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        doneButton.widthAnchor.constraint(equalTo: doneButton.heightAnchor, multiplier: 2.0).isActive = true
    }
    
    @objc func didSelectBack(){
        dismiss(animated: true, completion: nil)
    }
    

}
