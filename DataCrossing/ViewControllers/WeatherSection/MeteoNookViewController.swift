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
      
        weatherTable.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        view.backgroundColor = .sand
        weatherTable.backgroundColor = .sand
        
        addNavBar()
        getData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddWeather))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .coolGreen
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.rightBarButtonItem?.tintColor = .acWhite
        
        weatherTable.dataSource = self
        weatherTable.delegate = self
        
        view.addSubview(weatherTable)
        view.bringSubviewToFront(weatherTable)
        weatherTable.anchorToView(view: view, insets: UIEdgeInsets(top: 90, left: 0, bottom: 100, right: 0))
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
    
    let weatherAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Semibold", size: 18),
        NSAttributedString.Key.foregroundColor: UIColor.acWhite
    ]
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
        label.backgroundColor = .coolMint
        label.text = "\(savedDays[section].day).\(savedDays[section].month).\(savedDays[section].year)"
        label.attributedText = NSAttributedString(string: label.text!, attributes: weatherAttributes)
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
        cell.weatherImage.tintColor = .darkTeal
        
        var cellHour = hoursList[indexPath.row]!.hour
        
        if cellHour == 0 {
            cell.weatherText.text = "12 AM"
        } else if cellHour == 12 {
            cell.weatherText.text = "12 PM"
        } else if hoursList[indexPath.row]!.hour > 11 {
            cellHour = cellHour % 12
            cell.weatherText.text = "\(cellHour) PM"
        } else {
            cell.weatherText.text = "\(cellHour) AM"
        }
        cell.weatherImage.image = HourlyForecastCollectionViewCell().getWeatherImage(weather:
                                                                                        hoursList[indexPath.row]!.pattern!)
        cell.backgroundColor = .sand
        return cell
    }
    
}
