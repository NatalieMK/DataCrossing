//
//  MeteoNookViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

class MeteoNookViewController: UIViewController {

    let savedDays = [WeatherItem]()
    
    let weatherTable: UITableView = {
        let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherTable)
        weatherTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addNavBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddWeather))
    }
    
    @objc func didTapAddWeather(){
        let addWeather = AddWeatherItemViewController()
        let nav = UINavigationController(rootViewController: addWeather)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true, completion: nil)
    }
}

extension MeteoNookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(savedDays[section]){
        default:
            return savedDays[section].hours?.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .darkMint
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return savedDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
