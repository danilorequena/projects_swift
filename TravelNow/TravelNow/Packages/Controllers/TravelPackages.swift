//
//  TravelPackages.swift
//  TravelNow
//
//  Created by Danilo Requena on 28/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelPackages: UIViewController, UICollectionViewDataSource {
   
    
    @IBOutlet weak var collectionPackages: UICollectionView!
    
    let travelList: Array<Travel> = TravelDAO().returnAllTravels()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionPackages.dataSource = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "packageCell", for: indexPath) as! TravelPackagesCollectionViewCell
        let currentTravel = travelList[indexPath.row]
        
        packageCell.labelTitle.text = currentTravel.title
        packageCell.labelPrice.text = "A partir de R$\(currentTravel.price)"
        packageCell.labelCurrentDays.text = "\(currentTravel.numberOfDays) Dias"
        packageCell.imageTravel.image = UIImage(named: currentTravel.imagePath)
        
        packageCell.layer.borderWidth = 0.5
        packageCell.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        packageCell.layer.cornerRadius = 5
        return packageCell
    }
   

}
