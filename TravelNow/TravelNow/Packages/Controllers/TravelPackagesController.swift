//
//  TravelPackages.swift
//  TravelNow
//
//  Created by Danilo Requena on 28/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelPackagesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
   
    
    
    @IBOutlet weak var collectionPackages: UICollectionView!
    @IBOutlet weak var travelSearch: UISearchBar!
    @IBOutlet weak var labelNumberPackeges: UILabel!
    
    let travelListAll: Array<TravelPackages> = TravelPackagesDAO().returnAllTravels()
    var travelList: Array<TravelPackages> = []

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
        
        let currentPackages = travelList[indexPath.row]
        
        packageCell.labelTitle.text = currentPackages.travel.title
        packageCell.labelPrice.text = "A partir de R$\(currentPackages.travel.price)"
        packageCell.labelCurrentDays.text = "\(currentPackages.travel.numberOfDays) Dias"
        packageCell.imageTravel.image = UIImage(named: currentPackages.travel.imagePath)
        
        packageCell.layer.borderWidth = 0.5
        packageCell.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        packageCell.layer.cornerRadius = 5
        return packageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionView.bounds.width / 2
        return CGSize(width: widthCell - 15, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "packagesDetails") as! TravelDetailsViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        travelList = travelListAll
        if searchText != "" {
            let travelListFilter = NSPredicate(format: "title contains %@", searchText)
            let fiteredTravelList: Array<TravelPackages> = (travelList as NSArray).filtered(using: travelListFilter) as! Array
            travelList = fiteredTravelList
        }
        
        self.labelNumberPackeges.text = self.CountPackages()
        collectionPackages.reloadData()
    }
    
    func CountPackages() -> String {
       
        return travelList.count == 1 ? "1 pacote encontrado" : "\(travelList.count) pacotes encontrados."
    }
   

}
