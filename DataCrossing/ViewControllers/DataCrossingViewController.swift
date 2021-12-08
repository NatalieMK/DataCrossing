//
//  ViewController.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class DataCrossingViewController: UIViewController {
    
    let strBoi: String = """
    {
    "year": 2022,
    "day": 25,
    "month": 12,
    "seed" : 570191992
 }
"""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .acWhite
        let rustParse = RustParser()
        let rustJSON = rustParse.parseParse(to: strBoi)
        let data: Data? = rustJSON.data(using: .utf8)
        if let dateJSON = try? JSONDecoder().decode(Weather.self, from: data!){
            print(dateJSON.self.weather)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTabBar()
    }
    
    private func loadTabBar(){
        let tabBarVC = UITabBarController()
        let islandVC = UINavigationController(rootViewController: IslandDataViewController())
        let bellVC = UINavigationController(rootViewController: MoneyViewController())
        
        tabBarVC.view.backgroundColor = .acWhite
        
        tabBarVC.setViewControllers([islandVC, bellVC], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        islandVC.title = "Island"
        
        islandVC.tabBarItem.image = UIImage(systemName: "house.fill")
        bellVC.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        
        present(tabBarVC, animated: false)
    }
    


}

