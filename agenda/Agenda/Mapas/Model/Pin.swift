//
//  Pin.swift
//  Agenda
//
//  Created by Danilo Requena on 14/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation{
    
    var title: String?
    var icon: UIImage?
    var color: UIColor?
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    
}
