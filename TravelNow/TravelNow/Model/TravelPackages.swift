//
//  TravelPackages.swift
//  TravelNow
//
//  Created by Danilo Requena on 31/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class TravelPackages: NSObject {
    
    let hotelName: String
    let descriptionTravel: String
    let travelDate: String
    let travel: Travel

    init(hotelName: String, descriptionTravel: String, travelDate:String, travel: Travel) {
        self.hotelName = hotelName
        self.descriptionTravel = descriptionTravel
        self.travelDate = travelDate
        self.travel = travel
    }
}
