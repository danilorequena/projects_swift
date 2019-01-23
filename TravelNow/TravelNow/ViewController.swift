//
//  ViewController.swift
//  TravelNow
//
//  Created by Danilo Requena on 20/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var travelTable: UITableView!
    
    let travelList: Array<String> = ["Rio de Janeiro", "Ceará", "Paraná", "Rio Grande do Sul", "Porto Alegre", "USA"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.travelTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = travelList[indexPath.row]
        
        return cell
    }


}

