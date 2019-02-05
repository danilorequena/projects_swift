//
//  TravelDetailsViewController.swift
//  TravelNow
//
//  Created by Danilo Requena on 30/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit
import Foundation

class TravelDetailsViewController: UIViewController {

    @IBOutlet weak var ImageTravelPackage: UIImageView!
    @IBOutlet weak var labelTitleTravelPackage: UILabel!
    @IBOutlet weak var labelDescriptionTravelPackage: UILabel!
    @IBOutlet weak var labelTravelDate: UILabel!
    @IBOutlet weak var labelPriceTravelPackages: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finalizationButtonTravelPackage: UIButton!
    @IBOutlet weak var scrollMain: UIScrollView!
    @IBOutlet weak var textFieldDate: UITextField!
    
    var selectedTravelPackage: TravelPackages? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(IncreasesScroll(notification:)) , name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if let package = selectedTravelPackage {
            self.ImageTravelPackage.image = UIImage(named: package.travel.imagePath)
            self.labelTitleTravelPackage.text = package.travel.title
            self.labelDescriptionTravelPackage.text = package.descriptionTravel
            self.labelPriceTravelPackages.text = package.travel.price
            self.labelTravelDate.text = "válido para o período de: \(package.travelDate)"
            self.finalizationButtonTravelPackage.layer.cornerRadius = 5
        }

    }
    
    @objc       func IncreasesScroll (notification: Notification) {
        self.scrollMain.contentSize = CGSize(width: self.scrollMain.frame.width, height: self.scrollMain.frame.height + 320)
    }
    
    @IBAction func BackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func ShowDateTextField(sender: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "MM/yyyy"
        self.textFieldDate.text = formater.string(from: sender.date)
    }
    
    @IBAction func TextFieldComeIntoFoccus(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ShowDateTextField(sender:)), for: .valueChanged)
        
    }
    
    

}
