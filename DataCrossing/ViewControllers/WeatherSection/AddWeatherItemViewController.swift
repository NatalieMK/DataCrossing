//
//  AddWeatherItemViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

protocol AddWeatherItemControllerDelegate {
    func didAddEvent()
}
class AddWeatherItemViewController: UIViewController {
    
    var weatherDelegate: AddWeatherItemControllerDelegate!
    var chosenWeather = ""

    
    let alert: UIAlertController = {
       let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alert
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finish", for: .normal)
        button.backgroundColor = .acBrown
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let weatherOptions: UITableView = {
        let weather = UITableView()
        weather.backgroundColor = .paleBrown
        weather.translatesAutoresizingMaskIntoConstraints = false
        weather.layer.borderColor = UIColor.paleBrown.cgColor
        weather.layer.borderWidth = 5
        weather.backgroundColor = .acWhite
        return weather
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.tintColor = .coolBrown
        picker.minuteInterval = 30
        picker.roundsToMinuteInterval = true
        return picker
    }()
    
    let auroraLabel: UILabel = {
        let label = UILabel()
        label.text = "Aurora Borealis?"
        return label
    }()
    
    let meteorLabel: UILabel = {
        let label = UILabel()
        label.text = "Shooting Stars?"
        return label
    }()
    
    let auroraSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .acBrown
        switcher.tintColor = .paleBrown
        return switcher
    }()
    
    let meteorSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .acBrown
        switcher.tintColor = .paleBrown
        return switcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .acWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(didSelectBack))
        doneButton.addTarget(self, action: #selector(didSelectDoneButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem?.tintColor = .acBrown
        weatherOptions.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        view.addSubview(weatherOptions)
        weatherOptions.delegate = self
        weatherOptions.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(doneButton)
        view.bringSubviewToFront(doneButton)
        view.addSubview(datePicker)
        view.addSubview(meteorSwitch)
        view.addSubview(auroraSwitch)
        view.addSubview(auroraLabel)
        view.addSubview(meteorLabel)
        
        doneButton.anchorToConstraints(top: view.topAnchor, leading: nil, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 16))
        doneButton.heightAnchor.constraint(lessThanOrEqualToConstant: navigationController?.navigationBar.height ?? 100).isActive = true
        doneButton.widthAnchor.constraint(equalTo: doneButton.heightAnchor, multiplier: 2.0).isActive = true
        datePicker.anchorToConstraints(top: nil, leading: view.leadingAnchor, trailing: nil, bottom: nil, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        datePicker.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4).isActive = true
        meteorLabel.anchorToConstraints(top: meteorSwitch.topAnchor, leading: weatherOptions.leadingAnchor, trailing: meteorSwitch.leadingAnchor, bottom: meteorSwitch.bottomAnchor, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        meteorSwitch.anchorToConstraints(top: datePicker.bottomAnchor, leading: nil, trailing: doneButton.leadingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        auroraLabel.anchorToConstraints(top: auroraSwitch.topAnchor, leading: weatherOptions.leadingAnchor, trailing: auroraSwitch.leadingAnchor, bottom: auroraSwitch.bottomAnchor, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        auroraSwitch.anchorToConstraints(top: meteorSwitch.bottomAnchor, leading: meteorSwitch.leadingAnchor, trailing: nil, bottom: nil, insets: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        weatherOptions.anchorToConstraints(top: auroraSwitch.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        weatherOptions.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        weatherOptions.heightAnchor.constraint(greaterThanOrEqualTo: weatherOptions.widthAnchor).isActive = true
    }
    
    @objc func didSelectBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didSelectDoneButton(){
        if chosenWeather.isEmpty {
            alert.message = "No weather selected"
            present(alert, animated: false, completion: nil)
            return
        }
        let weatherController = WeatherItemController()
        let hour = Calendar.current.component(.hour, from: datePicker.date)
        do {
            try weatherController.saveWeatherForHour(hour: Int16(hour), pattern: chosenWeather, date: datePicker.date)
        } catch WeatherHourItemControllerError.noDaySaved {
            // make day and retry
            do {
                try weatherController.newWeatherItem(weatherDate: datePicker.date)
                try weatherController.saveWeatherForHour(hour: Int16(hour), pattern: chosenWeather, date: datePicker.date)
            }
            catch {
                alert.message = "An error has occurred. Try again."
                return
            }
            
        } catch WeatherHourItemControllerError.weatherNotPossible {
            alert.message = "Weather impossible - please double check"
            present(alert, animated: false, completion: nil)
            return
        } catch WeatherHourItemControllerError.hourAlreadyExists{
            alert.message = "Already a saved hour here"
            present(alert, animated: false, completion: nil)
            return
        } catch {
            alert.message = "An error has occurred"
            present(alert, animated: false, completion: nil)
            return
        }
        weatherDelegate.didAddEvent()
        dismiss(animated: true, completion: nil)
    }
}

extension AddWeatherItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height/6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            chosenWeather = "Clear"
        case 1:
            chosenWeather = "Sunny"
        case 2:
            chosenWeather = "Cloudy"
        case 3:
            chosenWeather = "RainClouds"
        case 4:
            chosenWeather = "Rain"
        default:
            chosenWeather = "HeavyRain"
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        switch (indexPath.row){
        case 0:
            cell.weatherImage.image = UIImage(systemName: "sun.max")
            cell.weatherText.text = "Clear/Fine"
        case 1:
            cell.weatherImage.image = UIImage(systemName: "cloud.sun")
            cell.weatherText.text = "Sunny with Clouds"
        case 2:
            cell.weatherImage.image = UIImage(systemName: "cloud")
            cell.weatherText.text = "Cloudy"
        case 3:
            cell.weatherImage.image = UIImage(systemName: "smoke.fill")
            cell.weatherText.text = "Rain Clouds"
        case 4:
            cell.weatherImage.image = UIImage(systemName: "cloud.drizzle")
            cell.weatherText.text = "Rain"
        default:
            cell.weatherImage.image = UIImage(systemName: "cloud.heavyrain")
            cell.weatherText.text = "Heavy Rain"
        }
        cell.weatherText.adjustsFontSizeToFitWidth = true
        cell.weatherImage.tintColor = .acBrown
        if cell.isSelected {
            cell.tintColor = .paleBrown
        }
        
        return cell
    }
    
    
}
