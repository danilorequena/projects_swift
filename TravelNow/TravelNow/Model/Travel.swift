//
//  Travel.swift
//  TravelNow
//
//  Created by Danilo Requena on 23/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation

class Travel: NSObject {
    let title: String
    let numberOfDays: Int
    let price: String
    let imagePath: String
    
    init(title: String, numberOfDays: Int, price: String, imagePath: String){
        self.title = title
        self.numberOfDays = numberOfDays
        self.price = price
        self.imagePath = imagePath
    }
}
