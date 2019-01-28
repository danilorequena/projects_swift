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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionPackages.dataSource = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "packageCell", for: indexPath) as! TravelPackagesCollectionViewCell
        packageCell.backgroundColor = UIColor.blue
        
        return packageCell
    }
   

}
