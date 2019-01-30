//
//  TravelPackages.swift
//  TravelNow
//
//  Created by Danilo Requena on 28/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelPackages: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
   
    
    
    @IBOutlet weak var collectionPackages: UICollectionView!
    @IBOutlet weak var travelSearch: UISearchBar!
    @IBOutlet weak var labelNumberPackeges: UILabel!
    
    let travelListAll: Array<Travel> = TravelDAO().returnAllTravels()
    var travelList: Array<Travel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        travelList = travelListAll
        collectionPackages.dataSource = self
        collectionPackages.delegate = self
        travelSearch.delegate = self
        self.labelNumberPackeges.text = self.CountPackages()

        

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionView.bounds.width / 2
        return CGSize(width: widthCell - 15, height: 160)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        travelList = travelListAll
        if searchText != "" {
            let travelListFilter = NSPredicate(format: "title contains %@", searchText)
            let fiteredTravelList: Array<Travel> = (travelList as NSArray).filtered(using: travelListFilter) as! Array
            travelList = fiteredTravelList
        }
        
        self.labelNumberPackeges.text = self.CountPackages()
        collectionPackages.reloadData()
    }
    
    func CountPackages() -> String {
       
        return travelList.count == 1 ? "1 pacote encontrado" : "\(travelList.count) pacotes encontrados."
    }
   

}
