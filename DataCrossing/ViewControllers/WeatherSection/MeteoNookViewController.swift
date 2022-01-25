//
//  MeteoNookViewController.swift
//  DataCrossing
//
//  Created by Natalie on 1/25/22.
//

import UIKit

class MeteoNookViewController: UIViewController {

    let weatherTable: UITableView = {
        let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension MeteoNookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    
    
    
}
