//
//  TableViewCell.swift
//  TravelNow
//
//  Created by Danilo Requena on 23/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCurrentDays: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var travelImage: UIImageView!
    
    func ConfigureCell(travel: Travel) {
        labelTitle.text = travel.title
        labelPrice.text = "R$\(travel.price)"
        labelCurrentDays.text = travel.numberOfDays == 1 ? "1 dia" : "\(travel.numberOfDays) Dias"
        travelImage.image = UIImage(named: travel.imagePath)
        
        travelImage.layer.cornerRadius = 10
        travelImage.layer.masksToBounds = true
    }
    

}
