//
//  MenuViewController.swift
//  DataCrossing
//
//  Created by Natalie on 12/14/21.
//

import UIKit


protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}
class MenuViewController: UIViewController {
    
    weak var chosenItemDelegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case island = "Island"
        case museum = "Museum"
        case weather = "Weather"
    
    var imageName: String {
        switch self {
        case .island:
            return "airplane"
        case .museum:
            return "building.columns"
        case .weather:
            return "cloud.sun"
        }
    }
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = nil
        view.backgroundColor = .paleBrown
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height/2)
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .acWhite
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.backgroundColor = .paleBrown
        cell.contentView.backgroundColor = .paleBrown
        cell.imageView?.tintColor = .acWhite
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        chosenItemDelegate?.didSelect(menuItem: item)
    }
}
