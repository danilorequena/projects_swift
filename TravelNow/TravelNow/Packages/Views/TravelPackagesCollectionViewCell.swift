//
//  TravelPackagesCollectionViewCell.swift
//  TravelNow
//
//  Created by Danilo Requena on 28/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelPackagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageTravel: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCurrentDays: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    
    func ConfigureCell (travelPackage: TravelPackages) {
        
        labelTitle.text = travelPackage.travel.title
        labelPrice.text = "A partir de R$\(travelPackage.travel.price)"
        labelCurrentDays.text = "\(travelPackage.travel.numberOfDays) Dias"
        imageTravel.image = UIImage(named: travelPackage.travel.imagePath)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        layer.cornerRadius = 5
    }

}


