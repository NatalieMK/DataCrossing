//
//  MeteoNookViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit
import SwiftUI

class MeteoNookViewController: UIViewController, AddWeatherItemControllerDelegate {
    
    func didAddEvent() {
        getData()
        weatherTable.reloadData()
    }
    
    var savedDays = [WeatherItem]()
    var weatherItemController = WeatherItemController()
    
    let weatherTable: UITableView = {
        let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherTable)
        weatherTable.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        addNavBar()
        getData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddWeather))
        navigationItem.rightBarButtonItem?.tintColor = .acWhite
        weatherTable.dataSource = self
        weatherTable.delegate = self
        weatherTable.frame = view.frame
    }
    
    func getData(){
        do {
            savedDays = try weatherItemController.getWeatherItems()
            print(savedDays)
        } catch {
            print("Error fetching data")
        }
    }
    
    @objc func didTapAddWeather(){
        let addWeather = AddWeatherItemViewController()
        let nav = UINavigationController(rootViewController: addWeather)
        addWeather.weatherDelegate = self
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true, completion: nil)
    }
}

extension MeteoNookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(savedDays[section]){
        default:
            return savedDays[section].hours?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height/15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .darkMint
        label.text = "\(savedDays[section].day) \(savedDays[section].month)"
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return savedDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        let hoursList = weatherItemController.getHourItems(weatherItem: savedDays[indexPath.section])
        if hoursList.count == 0 {return cell}
        cell.weatherText.textColor = .darkTeal
        cell.weatherText.text = "\(hoursList[indexPath.row]!.hour)"
        cell.weatherImage.image = HourlyForecastCollectionViewCell().getWeatherImage(weather:
                                                                                        hoursList[indexPath.row]!.pattern!)
        
        return cell
    }
    
}
