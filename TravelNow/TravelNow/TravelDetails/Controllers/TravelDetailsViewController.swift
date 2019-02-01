//
//  TravelDetailsViewController.swift
//  TravelNow
//
//  Created by Danilo Requena on 30/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelDetailsViewController: UIViewController {

    @IBOutlet weak var ImageTravelPackage: UIImageView!
    @IBOutlet weak var labelTitleTravelPackage: UILabel!
    @IBOutlet weak var labelDescriptionTravelPackage: UILabel!
    @IBOutlet weak var labelTravelDate: UILabel!
    @IBOutlet weak var labelPriceTravelPackages: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var selectedTravelPackage: TravelPackages? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let package = selectedTravelPackage {
            self.ImageTravelPackage.image = UIImage(named: package.travel.imagePath)
            self.labelTitleTravelPackage.text = package.travel.title
            self.labelDescriptionTravelPackage.text = package.descriptionTravel
            self.labelPriceTravelPackages.text = package.travel.price
            self.labelTravelDate.text = "válido para o período de: \(package.travelDate)"
        }

    }
    @IBAction func BackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
