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
        packageCell.ConfigureCell(travelPackage: currentPackages)
        
       
        return packageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let widthCell = collectionView.bounds.width / 2
//        return CGSize(width: widthCell - 15, height: 160)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
           return CGSize(width: collectionView.bounds.width / 2 - 20, height: 160)
        default:
         return   CGSize(width: collectionView.bounds.width / 3 - 20, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = travelList[indexPath.item]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "packagesDetails") as! TravelDetailsViewController
        controller.selectedTravelPackage = package
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        travelList = travelListAll
        if searchText != "" {
            travelList = travelList.filter({ $0.travel.title.contains(searchText) })
        }
        
        self.labelNumberPackeges.text = self.CountPackages()
        collectionPackages.reloadData()
    }
    
    func CountPackages() -> String {
       
        return travelList.count == 1 ? "1 pacote encontrado" : "\(travelList.count) pacotes encontrados."
    }
   

}
