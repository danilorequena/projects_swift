//
//  PaymentConfirmationViewController.swift
//  TravelNow
//
//  Created by Danilo Requena on 05/02/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class PaymentConfirmationViewController: UIViewController {

    @IBOutlet weak var imagePackageTravel: UIImageView!
    @IBOutlet weak var labelTitlePackageTravel: UILabel!
    @IBOutlet weak var labelHotelPackageTravel: UILabel!
    @IBOutlet weak var labelDatePackageTravel: UILabel!
    @IBOutlet weak var labelAmountPeoplePackageTravel: UILabel!
    @IBOutlet weak var labelDescriptionPackageTravel: UILabel!
    @IBOutlet weak var buttonBackToHome: UIButton!
    
    var packagePurchased: TravelPackages? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let package = packagePurchased {
            self.imagePackageTravel.image = UIImage(named: package.travel.imagePath)
            self.labelTitlePackageTravel.text = package.travel.title.uppercased()
            self.labelHotelPackageTravel.text = package.hotelName
            self.labelDatePackageTravel.text = package.travelDate
            self.labelDescriptionPackageTravel.text = package.descriptionTravel
            
            self.imagePackageTravel.layer.cornerRadius = 10
            self.imagePackageTravel.layer.masksToBounds = true
            self.buttonBackToHome.layer.cornerRadius = 8
        }

        
    }
    
    @IBAction func ButtonBackToHome(_ sender: UIButton) {
        if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: true)
        }
    }
    
  

}
